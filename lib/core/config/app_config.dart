/// Configuration read from `--dart-define` at build time.
///
/// Three access modes for the Shamo backend (Laravel Valet):
///   1. Emulator → Valet:  `API_BASE_URL=http://10.0.2.2`
///   2. Physical phone → Valet: `API_BASE_URL=http://<Mac-LAN-IP>`
///   3. Any device → ngrok: `API_BASE_URL=https://<sub>.ngrok-free.dev`
///
/// In modes 1 & 2 the app must send `Host: shamoapps.test` so Valet can route.
/// In mode 3, ngrok rewrites the Host server-side — the app must NOT send it.
/// Toggle with `--dart-define=API_USE_NGROK=true` (default false).
class AppConfig {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://fibromatous-jerald-postsurgical.ngrok-free.dev',
  );

  /// When true, the Host interceptor skips attaching `Host: shamoapps.test`.
  static const useNgrok = bool.fromEnvironment(
    'API_USE_NGROK',
    defaultValue: false,
  );

  /// The Host header value Valet expects for routing.
  static const valetHost = 'shamoapps.test';
}