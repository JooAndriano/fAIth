// Rules tests for the public `devotionals` collection. Run with `npm test` (starts the emulator).
import { readFileSync } from 'node:fs';
import path from 'node:path';
import { after, before, beforeEach, describe, test } from 'node:test';
import { fileURLToPath } from 'node:url';

import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  collection,
  deleteDoc,
  doc,
  getDoc,
  getDocs,
  orderBy,
  query,
  setDoc,
  updateDoc,
  where,
} from 'firebase/firestore';

const here = path.dirname(fileURLToPath(import.meta.url));
const RULES = readFileSync(path.join(here, '..', '..', 'firestore.rules'), 'utf8');

const devotional = (dayNumber, status) => ({
  id: `day-${String(dayNumber).padStart(3, '0')}`,
  dayNumber,
  title: 'Judul',
  verseRef: 'JHN:14:27',
  verseText: 'Teks ayat.',
  body: 'Isi renungan.',
  reflectionQuestions: ['Pertanyaan?'],
  prayer: 'Doa.',
  tags: ['damai'],
  status,
});

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-faith',
    firestore: { rules: RULES },
  });
});

after(async () => {
  await env?.cleanup();
});

beforeEach(async () => {
  await env.clearFirestore();
  // Admin-style seed, bypassing rules (like tools/seed).
  await env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await setDoc(doc(db, 'devotionals/day-001'), devotional(1, 'published'));
    await setDoc(doc(db, 'devotionals/day-002'), devotional(2, 'draft'));
  });
});

const authed = () => env.authenticatedContext('alice').firestore();
const anon = () => env.unauthenticatedContext().firestore();

describe('devotionals: read', () => {
  test('signed-in user can read a published devotional', async () => {
    await assertSucceeds(getDoc(doc(authed(), 'devotionals/day-001')));
  });

  test('signed-in user cannot read a draft devotional', async () => {
    await assertFails(getDoc(doc(authed(), 'devotionals/day-002')));
  });

  test('signed-out user cannot read a published devotional', async () => {
    await assertFails(getDoc(doc(anon(), 'devotionals/day-001')));
  });

  test('query filtered on status == published succeeds', async () => {
    const q = query(
      collection(authed(), 'devotionals'),
      where('status', '==', 'published'),
      orderBy('dayNumber'),
    );
    await assertSucceeds(getDocs(q));
  });

  test('unfiltered query is denied (could include drafts)', async () => {
    await assertFails(getDocs(collection(authed(), 'devotionals')));
  });
});

describe('devotionals: client writes are denied', () => {
  test('create', async () => {
    await assertFails(setDoc(doc(authed(), 'devotionals/day-003'), devotional(3, 'published')));
  });

  test('update', async () => {
    await assertFails(updateDoc(doc(authed(), 'devotionals/day-001'), { title: 'Diubah' }));
  });

  test('delete', async () => {
    await assertFails(deleteDoc(doc(authed(), 'devotionals/day-001')));
  });

  test('signed-out create', async () => {
    await assertFails(setDoc(doc(anon(), 'devotionals/day-003'), devotional(3, 'published')));
  });
});

describe('old collection name', () => {
  test('daily_devotionals is no longer readable', async () => {
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'daily_devotionals/x'), { title: 'lama' });
    });
    await assertFails(getDoc(doc(authed(), 'daily_devotionals/x')));
  });
});
