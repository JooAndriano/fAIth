// Pure helpers for the devotional seed script (no Firebase imports, so they are unit-testable).
import { readdir, readFile } from 'node:fs/promises';
import path from 'node:path';

export const STATUSES = ['draft', 'published'];

// Same shape as VerseRef.parse in the app: BOOK:chapter:verse[-verseEnd], e.g. PSA:23:1, PHP:4:6-7.
const VERSE_REF = /^([1-3]?[A-Z]{2,3}):(\d+):(\d+)(?:-(\d+))?$/;

/** Fields that are written to Firestore, in a fixed order. */
export const CONTENT_FIELDS = [
  'id',
  'dayNumber',
  'title',
  'verseRef',
  'verseText',
  'body',
  'reflectionQuestions',
  'prayer',
  'tags',
  'status',
];

/** Stable document ID derived from dayNumber, matching the app's mock ids (day-001). */
export function docIdFor(dayNumber) {
  return `day-${String(dayNumber).padStart(3, '0')}`;
}

const isNonEmptyString = (v) => typeof v === 'string' && v.trim().length > 0;
const isStringArray = (v) => Array.isArray(v) && v.every(isNonEmptyString);

/**
 * Validates one devotional object. Returns { errors: string[], warnings: string[] }.
 * Errors block the whole run; warnings are printed only.
 */
export function validateDevotional(d) {
  const errors = [];
  const warnings = [];
  if (d === null || typeof d !== 'object' || Array.isArray(d)) {
    return { errors: ['root must be a JSON object'], warnings };
  }

  if (!Number.isInteger(d.dayNumber) || d.dayNumber < 1 || d.dayNumber > 999) {
    errors.push('dayNumber must be an integer 1..999');
  }
  for (const f of ['title', 'verseText', 'body', 'prayer']) {
    if (!isNonEmptyString(d[f])) errors.push(`${f} must be a non-empty string`);
  }
  if (typeof d.verseRef !== 'string' || !VERSE_REF.test(d.verseRef)) {
    errors.push('verseRef must look like BOOK:chapter:verse[-end], e.g. JHN:14:27');
  } else {
    const [, , , start, end] = d.verseRef.match(VERSE_REF);
    if (end !== undefined && Number(end) <= Number(start)) errors.push('verseRef end must be > start');
  }
  if (!isStringArray(d.reflectionQuestions) || d.reflectionQuestions.length === 0) {
    errors.push('reflectionQuestions must be a non-empty array of strings');
  }
  if (d.tags !== undefined && !isStringArray(d.tags)) errors.push('tags must be an array of strings');
  if (!STATUSES.includes(d.status)) errors.push(`status must be one of: ${STATUSES.join(', ')}`);

  if (Number.isInteger(d.dayNumber) && d.id !== undefined && d.id !== docIdFor(d.dayNumber)) {
    errors.push(`id "${d.id}" does not match dayNumber (expected "${docIdFor(d.dayNumber)}")`);
  }

  const unknown = Object.keys(d).filter((k) => !CONTENT_FIELDS.includes(k));
  if (unknown.length) warnings.push(`unknown fields ignored: ${unknown.join(', ')}`);
  if (typeof d.verseText === 'string' && d.verseText.startsWith('[CONTOH]')) {
    warnings.push('verseText is still a placeholder — replace it with text from the AYT asset');
  }
  return { errors, warnings };
}

/** Builds the Firestore payload (content fields only, normalized). */
export function toFirestoreDoc(d) {
  return {
    id: docIdFor(d.dayNumber),
    dayNumber: d.dayNumber,
    title: d.title.trim(),
    verseRef: d.verseRef,
    verseText: d.verseText.trim(),
    body: d.body.trim(),
    reflectionQuestions: d.reflectionQuestions.map((q) => q.trim()),
    prayer: d.prayer.trim(),
    tags: (d.tags ?? []).map((t) => t.trim()),
    status: d.status,
  };
}

/** True when the stored document already holds exactly this content (timestamps ignored). */
export function sameContent(stored, payload) {
  if (!stored) return false;
  return CONTENT_FIELDS.every((f) => JSON.stringify(stored[f]) === JSON.stringify(payload[f]));
}

/**
 * Reads every *.json file in dir. Returns { items: [{file, data}], errors: string[] }.
 * Also checks dayNumber uniqueness across files.
 */
export async function loadDevotionals(dir) {
  const names = (await readdir(dir)).filter((n) => n.toLowerCase().endsWith('.json')).sort();
  const items = [];
  const errors = [];
  const warnings = [];
  const seenDays = new Map();

  for (const name of names) {
    const file = path.join(dir, name);
    let data;
    try {
      data = JSON.parse(await readFile(file, 'utf8'));
    } catch (e) {
      errors.push(`${name}: invalid JSON (${e.message})`);
      continue;
    }
    const v = validateDevotional(data);
    v.errors.forEach((m) => errors.push(`${name}: ${m}`));
    v.warnings.forEach((m) => warnings.push(`${name}: ${m}`));
    if (Number.isInteger(data?.dayNumber)) {
      if (seenDays.has(data.dayNumber)) {
        errors.push(`${name}: dayNumber ${data.dayNumber} already used by ${seenDays.get(data.dayNumber)}`);
      } else {
        seenDays.set(data.dayNumber, name);
      }
    }
    items.push({ file: name, data });
  }
  return { items, errors, warnings };
}

/** True when target is inside (or equal to) dir. */
export function isInside(target, dir) {
  const rel = path.relative(path.resolve(dir), path.resolve(target));
  return rel === '' || (!rel.startsWith('..') && !path.isAbsolute(rel));
}
