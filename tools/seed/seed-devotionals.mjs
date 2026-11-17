#!/usr/bin/env node
// Seeds published devotionals from content/devotionals/*.json into Firestore.
// See README.md for usage. Credentials come from GOOGLE_APPLICATION_CREDENTIALS only.
import { existsSync, readFileSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseArgs } from 'node:util';

import { docIdFor, isInside, loadDevotionals, sameContent, toFirestoreDoc } from './lib.mjs';

const HERE = path.dirname(fileURLToPath(import.meta.url));
const REPO_ROOT = path.resolve(HERE, '..', '..');
const DEFAULT_DIR = path.join(REPO_ROOT, 'content', 'devotionals');
const DEFAULT_EMULATOR_HOST = '127.0.0.1:8080';

const USAGE = `Usage: node seed-devotionals.mjs (--project <id> | --emulator) [options]

  --project <id>        Firebase project to write to (e.g. faith-514ef)
  --emulator            Write to the Firestore emulator (FIRESTORE_EMULATOR_HOST or ${DEFAULT_EMULATOR_HOST})
  --dry-run             Only print what would be written; no Firebase connection at all
  --database <id>       Firestore database ID (default: "(default)")
  --collection <name>   Target collection (default: devotionals)
  --dir <path>          Source folder (default: content/devotionals)
  -h, --help            Show this help`;

function fail(msg) {
  console.error(`\n✖ ${msg}`);
  process.exit(1);
}

const { values: opts } = (() => {
  try {
    return parseArgs({
      options: {
        project: { type: 'string' },
        emulator: { type: 'boolean', default: false },
        'dry-run': { type: 'boolean', default: false },
        database: { type: 'string', default: '(default)' },
        collection: { type: 'string', default: 'devotionals' },
        dir: { type: 'string', default: DEFAULT_DIR },
        help: { type: 'boolean', short: 'h', default: false },
      },
      strict: true,
    });
  } catch (e) {
    fail(`${e.message}\n\n${USAGE}`);
  }
})();

if (opts.help) {
  console.log(USAGE);
  process.exit(0);
}

const dryRun = opts['dry-run'];
if (!dryRun && !opts.project && !opts.emulator) {
  fail(`Pass --project <id>, --emulator or --dry-run.\n\n${USAGE}`);
}
const projectId = opts.project ?? 'faith-514ef';
const dir = path.resolve(opts.dir);
if (!existsSync(dir)) fail(`Source folder not found: ${dir}`);

// ---- 1. Load + validate everything before touching Firestore ----
const { items, errors, warnings } = await loadDevotionals(dir);
warnings.forEach((w) => console.warn(`⚠ ${w}`));
if (errors.length) fail(`Validation failed — nothing was written:\n  - ${errors.join('\n  - ')}`);

const published = items.filter((i) => i.data.status === 'published');
const drafts = items.filter((i) => i.data.status !== 'published');
const target = opts.emulator
  ? `emulator ${process.env.FIRESTORE_EMULATOR_HOST ?? DEFAULT_EMULATOR_HOST}`
  : `project ${projectId}`;

console.log(`Source     : ${dir}`);
console.log(`Files      : ${items.length} (${published.length} published, ${drafts.length} draft — drafts are skipped)`);
console.log(`Target     : ${target}, database ${opts.database}, collection "${opts.collection}"`);
console.log(`Mode       : ${dryRun ? 'DRY RUN (no connection, nothing written)' : 'WRITE'}\n`);

if (dryRun) {
  for (const { file, data } of published) {
    const doc = toFirestoreDoc(data);
    console.log(`would set ${opts.collection}/${doc.id}  ← ${file}`);
    console.log(JSON.stringify(doc, null, 2).replace(/^/gm, '    '));
  }
  for (const { file, data } of drafts) console.log(`skip (draft) ${docIdFor(data.dayNumber)}  ← ${file}`);
  console.log(`\nDry run done: ${published.length} document(s) would be upserted.`);
  process.exit(0);
}

// ---- 2. Connect ----
if (opts.emulator) {
  process.env.FIRESTORE_EMULATOR_HOST ??= DEFAULT_EMULATOR_HOST;
} else {
  if (process.env.FIRESTORE_EMULATOR_HOST) {
    fail('FIRESTORE_EMULATOR_HOST is set but --emulator was not passed. Unset it to write to a real project.');
  }
  const keyPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;
  if (!keyPath) fail('GOOGLE_APPLICATION_CREDENTIALS is not set. See README.md → "Kredensial".');
  if (!existsSync(keyPath)) fail(`GOOGLE_APPLICATION_CREDENTIALS points to a missing file: ${keyPath}`);
  if (isInside(keyPath, REPO_ROOT)) {
    fail(`Refusing to use a service-account key inside the repo (${keyPath}). Move it outside ${REPO_ROOT}.`);
  }
  let keyProject;
  try {
    keyProject = JSON.parse(readFileSync(keyPath, 'utf8')).project_id;
  } catch {
    fail(`Could not read the key file as JSON: ${keyPath}`);
  }
  if (keyProject && keyProject !== projectId) {
    fail(`Key belongs to project "${keyProject}" but --project is "${projectId}".`);
  }
}

const { initializeApp, applicationDefault } = await import('firebase-admin/app');
const { getFirestore, FieldValue } = await import('firebase-admin/firestore');

const app = initializeApp(
  opts.emulator ? { projectId } : { projectId, credential: applicationDefault() },
);
const db = opts.database === '(default)' ? getFirestore(app) : getFirestore(app, opts.database);
const col = db.collection(opts.collection);

// ---- 3. Upsert published docs (skip unchanged ones to save writes) ----
const refs = items.map(({ data }) => col.doc(docIdFor(data.dayNumber)));
const snaps = refs.length ? await db.getAll(...refs) : [];
const existing = new Map(snaps.map((s) => [s.id, s.exists ? s.data() : null]));

const batch = db.batch();
let created = 0;
let updated = 0;
let unchanged = 0;

for (const { file, data } of published) {
  const doc = toFirestoreDoc(data);
  const stored = existing.get(doc.id);
  if (sameContent(stored, doc)) {
    unchanged++;
    console.log(`= unchanged ${doc.id}  ← ${file}`);
    continue;
  }
  const ts = { updatedAt: FieldValue.serverTimestamp() };
  if (!stored) ts.createdAt = FieldValue.serverTimestamp();
  batch.set(col.doc(doc.id), { ...doc, ...ts }, { merge: true });
  stored ? updated++ : created++;
  console.log(`${stored ? '~ update' : '+ create'}   ${doc.id}  ← ${file}`);
}

for (const { file, data } of drafts) {
  const id = docIdFor(data.dayNumber);
  if (existing.get(id)) {
    console.warn(`⚠ ${id} is "draft" locally (${file}) but exists in Firestore — left untouched; delete it manually if needed.`);
  }
}

if (created + updated > 0) await batch.commit(); // ≤ 500 ops; 30 devotionals fits easily
console.log(`\nDone: ${created} created, ${updated} updated, ${unchanged} unchanged, ${drafts.length} draft skipped.`);
