import 'package:dio/dio.dart';
import 'package:shamoapps/core/config/app_config.dart';

/// Attaches `Host: shamoapps.test` in direct-to-Valet modes (emulator / LAN)
/// so that Valet's nginx can route the request to the correct site.
///
/// Skipped when [AppConfig.useNgrok] is true — ngrok rewrites the Host
/// server-side via `ngrok http --host-header=shamoapps.test 80`.
///
/// Note: `Host` in `BaseOptions.headers` is unreliable — `dart:io` HttpClient
/// may drop or overwrite it (dio issue #1577). Setting it here in `onRequest`
/// combined with `preserveHeaderCase: true` on BaseOptions avoids that.
class HostInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!AppConfig.useNgrok) {
      options.headers['Host'] = AppConfig.valetHost;
    }
    handler.next(options);
  }
}