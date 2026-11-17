/// Old or New Testament (Perjanjian Lama / Perjanjian Baru).
enum Testament { old, newT }

/// Canonical book metadata. Ids are USFM codes, used in stored verse references.
///
/// Chapter counts follow the common English versification; Phase 3 Bible assets
/// are the source of truth for verse data.
class BibleBook {
  const BibleBook(this.id, this.nameId, this.nameEn, this.chapters, this.testament);

  final String id;
  final String nameId;
  final String nameEn;
  final int chapters;
  final Testament testament;

  /// Display name for a translation language (`id` or `en`).
  String nameFor(String language) => language == 'en' ? nameEn : nameId;
}

abstract final class BibleBooks {
  static const List<BibleBook> all = [
    BibleBook('GEN', 'Kejadian', 'Genesis', 50, Testament.old),
    BibleBook('EXO', 'Keluaran', 'Exodus', 40, Testament.old),
    BibleBook('LEV', 'Imamat', 'Leviticus', 27, Testament.old),
    BibleBook('NUM', 'Bilangan', 'Numbers', 36, Testament.old),
    BibleBook('DEU', 'Ulangan', 'Deuteronomy', 34, Testament.old),
    BibleBook('JOS', 'Yosua', 'Joshua', 24, Testament.old),
    BibleBook('JDG', 'Hakim-hakim', 'Judges', 21, Testament.old),
    BibleBook('RUT', 'Rut', 'Ruth', 4, Testament.old),
    BibleBook('1SA', '1 Samuel', '1 Samuel', 31, Testament.old),
    BibleBook('2SA', '2 Samuel', '2 Samuel', 24, Testament.old),
    BibleBook('1KI', '1 Raja-raja', '1 Kings', 22, Testament.old),
    BibleBook('2KI', '2 Raja-raja', '2 Kings', 25, Testament.old),
    BibleBook('1CH', '1 Tawarikh', '1 Chronicles', 29, Testament.old),
    BibleBook('2CH', '2 Tawarikh', '2 Chronicles', 36, Testament.old),
    BibleBook('EZR', 'Ezra', 'Ezra', 10, Testament.old),
    BibleBook('NEH', 'Nehemia', 'Nehemiah', 13, Testament.old),
    BibleBook('EST', 'Ester', 'Esther', 10, Testament.old),
    BibleBook('JOB', 'Ayub', 'Job', 42, Testament.old),
    BibleBook('PSA', 'Mazmur', 'Psalms', 150, Testament.old),
    BibleBook('PRO', 'Amsal', 'Proverbs', 31, Testament.old),
    BibleBook('ECC', 'Pengkhotbah', 'Ecclesiastes', 12, Testament.old),
    BibleBook('SNG', 'Kidung Agung', 'Song of Songs', 8, Testament.old),
    BibleBook('ISA', 'Yesaya', 'Isaiah', 66, Testament.old),
    BibleBook('JER', 'Yeremia', 'Jeremiah', 52, Testament.old),
    BibleBook('LAM', 'Ratapan', 'Lamentations', 5, Testament.old),
    BibleBook('EZK', 'Yehezkiel', 'Ezekiel', 48, Testament.old),
    BibleBook('DAN', 'Daniel', 'Daniel', 12, Testament.old),
    BibleBook('HOS', 'Hosea', 'Hosea', 14, Testament.old),
    BibleBook('JOL', 'Yoel', 'Joel', 3, Testament.old),
    BibleBook('AMO', 'Amos', 'Amos', 9, Testament.old),
    BibleBook('OBA', 'Obaja', 'Obadiah', 1, Testament.old),
    BibleBook('JON', 'Yunus', 'Jonah', 4, Testament.old),
    BibleBook('MIC', 'Mikha', 'Micah', 7, Testament.old),
    BibleBook('NAM', 'Nahum', 'Nahum', 3, Testament.old),
    BibleBook('HAB', 'Habakuk', 'Habakkuk', 3, Testament.old),
    BibleBook('ZEP', 'Zefanya', 'Zephaniah', 3, Testament.old),
    BibleBook('HAG', 'Hagai', 'Haggai', 2, Testament.old),
    BibleBook('ZEC', 'Zakharia', 'Zechariah', 14, Testament.old),
    BibleBook('MAL', 'Maleakhi', 'Malachi', 4, Testament.old),
    BibleBook('MAT', 'Matius', 'Matthew', 28, Testament.newT),
    BibleBook('MRK', 'Markus', 'Mark', 16, Testament.newT),
    BibleBook('LUK', 'Lukas', 'Luke', 24, Testament.newT),
    BibleBook('JHN', 'Yohanes', 'John', 21, Testament.newT),
    BibleBook('ACT', 'Kisah Para Rasul', 'Acts', 28, Testament.newT),
    BibleBook('ROM', 'Roma', 'Romans', 16, Testament.newT),
    BibleBook('1CO', '1 Korintus', '1 Corinthians', 16, Testament.newT),
    BibleBook('2CO', '2 Korintus', '2 Corinthians', 13, Testament.newT),
    BibleBook('GAL', 'Galatia', 'Galatians', 6, Testament.newT),
    BibleBook('EPH', 'Efesus', 'Ephesians', 6, Testament.newT),
    BibleBook('PHP', 'Filipi', 'Philippians', 4, Testament.newT),
    BibleBook('COL', 'Kolose', 'Colossians', 4, Testament.newT),
    BibleBook('1TH', '1 Tesalonika', '1 Thessalonians', 5, Testament.newT),
    BibleBook('2TH', '2 Tesalonika', '2 Thessalonians', 3, Testament.newT),
    BibleBook('1TI', '1 Timotius', '1 Timothy', 6, Testament.newT),
    BibleBook('2TI', '2 Timotius', '2 Timothy', 4, Testament.newT),
    BibleBook('TIT', 'Titus', 'Titus', 3, Testament.newT),
    BibleBook('PHM', 'Filemon', 'Philemon', 1, Testament.newT),
    BibleBook('HEB', 'Ibrani', 'Hebrews', 13, Testament.newT),
    BibleBook('JAS', 'Yakobus', 'James', 5, Testament.newT),
    BibleBook('1PE', '1 Petrus', '1 Peter', 5, Testament.newT),
    BibleBook('2PE', '2 Petrus', '2 Peter', 3, Testament.newT),
    BibleBook('1JN', '1 Yohanes', '1 John', 5, Testament.newT),
    BibleBook('2JN', '2 Yohanes', '2 John', 1, Testament.newT),
    BibleBook('3JN', '3 Yohanes', '3 John', 1, Testament.newT),
    BibleBook('JUD', 'Yudas', 'Jude', 1, Testament.newT),
    BibleBook('REV', 'Wahyu', 'Revelation', 22, Testament.newT),
  ];

  static final Map<String, BibleBook> _byId = {for (final b in all) b.id: b};

  /// Book by USFM id, or null if unknown.
  static BibleBook? byId(String id) => _byId[id];
}
