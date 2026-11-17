/// App-wide configuration constants. Never put API keys or other secrets here.
abstract final class AppConfig {
  /// Base URL of the AI gateway (Cloudflare Worker `faith-ai-gateway`).
  static const String aiBaseUrl = 'https://ai.jivottama.dev';
}
