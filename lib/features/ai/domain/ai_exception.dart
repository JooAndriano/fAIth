/// Why an AI request failed.
enum AiErrorKind {
  /// Not signed in, token unavailable, or the gateway answered 401.
  unauthenticated,

  /// Daily quota used up (429).
  rateLimited,

  /// Gateway or provider busy/unreachable: 502/503/504, timeout, no network.
  unavailable,

  /// The request was rejected as invalid (400).
  badRequest,

  /// Anything else.
  unknown,
}

/// Failure of an AI request. [message] is user-facing (Bahasa Indonesia).
class AiException implements Exception {
  const AiException(this.kind, this.message);

  final AiErrorKind kind;
  final String message;

  static const String loginAgainMessage = 'Sesi kamu telah berakhir. Silakan masuk kembali.';
  static const String rateLimitedMessage =
      'Kamu sudah mencapai batas percakapan untuk hari ini. Mari lanjutkan lagi besok.';
  static const String busyMessage = 'Layanan sedang sibuk, coba lagi nanti.';
  static const String badRequestMessage = 'Pesan tidak dapat diproses.';
  static const String unknownMessage = 'Terjadi kesalahan. Silakan coba lagi nanti.';

  @override
  String toString() => 'AiException(${kind.name}): $message';
}
