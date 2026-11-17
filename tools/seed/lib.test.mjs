import assert from 'node:assert/strict';
import { mkdtemp, writeFile } from 'node:fs/promises';
import os from 'node:os';
import path from 'node:path';
import { test } from 'node:test';

import { docIdFor, isInside, loadDevotionals, sameContent, toFirestoreDoc, validateDevotional } from './lib.mjs';

const valid = () => ({
  id: 'day-001',
  dayNumber: 1,
  title: 'Judul',
  verseRef: 'JHN:14:27',
  verseText: 'Teks ayat.',
  body: 'Isi renungan.',
  reflectionQuestions: ['Pertanyaan?'],
  prayer: 'Doa.',
  tags: ['damai'],
  status: 'published',
});

test('docIdFor pads to three digits', () => {
  assert.equal(docIdFor(1), 'day-001');
  assert.equal(docIdFor(30), 'day-030');
});

test('valid devotional has no errors', () => {
  assert.deepEqual(validateDevotional(valid()).errors, []);
});

test('rejects bad fields', () => {
  const d = { ...valid(), id: undefined, dayNumber: 0, verseRef: 'John 3:16', status: 'live', reflectionQuestions: [] };
  const { errors } = validateDevotional(d);
  assert.equal(errors.length, 4);
});

test('rejects id that does not match dayNumber', () => {
  const { errors } = validateDevotional({ ...valid(), id: 'day-002' });
  assert.match(errors[0], /does not match dayNumber/);
});

test('rejects reversed verse range', () => {
  assert.ok(validateDevotional({ ...valid(), verseRef: 'PHP:4:7-6' }).errors.length);
  assert.deepEqual(validateDevotional({ ...valid(), verseRef: 'PHP:4:6-7' }).errors, []);
});

test('sameContent ignores timestamps and detects changes', () => {
  const doc = toFirestoreDoc(valid());
  assert.ok(sameContent({ ...doc, createdAt: 1, updatedAt: 2 }, doc));
  assert.ok(!sameContent({ ...doc, title: 'Lain' }, doc));
  assert.ok(!sameContent(null, doc));
});

test('loadDevotionals reports duplicate dayNumber', async () => {
  const dir = await mkdtemp(path.join(os.tmpdir(), 'seed-test-'));
  await writeFile(path.join(dir, 'a.json'), JSON.stringify(valid()));
  await writeFile(path.join(dir, 'b.json'), JSON.stringify(valid()));
  const { errors, items } = await loadDevotionals(dir);
  assert.equal(items.length, 2);
  assert.match(errors.join(), /already used/);
});

test('isInside', () => {
  assert.ok(isInside('/a/b/c.json', '/a'));
  assert.ok(!isInside('/x/c.json', '/a'));
});
