# Task: Diagnose "Server error, please try again" in the app while the same request returns 200 in Apidog

You are a senior Flutter engineer debugging a Shamo app (Clean Architecture + BLoC,
Dio networking, Laravel Valet backend at `http://shamoapps.test`). A request that
returns **200 with a `{ meta, data }` JSON body in Apidog** fails **in the app** with
the message `Server error, please try again` (or `Server error`).

Work **evidence-first**: do not "fix" anything until you have captured the actual
request the app sends and the actual response body it receives. Apidog succeeding
only proves the endpoint is fine — it does **not** prove the app sends the same
request. Your job is to find the difference between the two requests.

## What the error message already tells you

The string `Server error` / `Server error, please try again` is **not** produced by
the backend. It comes from the app's own `core/network/error_mapper.dart`, from the
branches that fire when the response body is **not a JSON map**:

```dart
if (body is String) return const ServerFailure('Server error');
// ...and the connectivity branch:
return const NetworkFailure('Network problem, please try again');
```

Therefore the leading hypothesis is: **the app receives a non-JSON body** (most
likely HTML such as Laravel Valet's `404 - Not Found` page, or an nginx/ngrok error
page), while Apidog receives real JSON. The error mapper is behaving **correctly** by
refusing to feed non-JSON into `fromJson`; the real defect is one layer below — why
the app's request never reaches Laravel the way Apidog's does. Do not "fix" the error
mapper. Fix the request.

## Step 1 — Capture the real request/response (do this before anything else)

Add a logging interceptor to the main Dio instance (temporarily) and reproduce the
failing call once:

```dart
dio.interceptors.add(LogInterceptor(
  request: true,
  requestHeader: true,   // CRITICAL: reveals whether `Host` and `Accept` are sent
  requestBody: true,
  responseHeader: true,
  responseBody: true,    // reveals whether the body is HTML or JSON
  error: true,
));
```

Also print the resolved config once at startup so there is no ambiguity about which
mode is active:

```dart
debugPrint('BASE_URL=${AppConfig.baseUrl} USE_NGROK=${AppConfig.useNgrok}');
```

Reproduce the failing request, then collect from the logs:

1. The **final request URL** (scheme + host + path + query).
2. The **request headers** actually sent — especially `Host`, `Accept`,
   `Authorization`, and (for cart/checkout) `X-CART-ID` / `X-CART-SECRET`.
3. The **response status code** and the **first ~200 chars of the response body**
   (is it `<html>… Valet - Not Found`, an ngrok error, or JSON?).

Then obtain the **equivalent Apidog request** ("Actual request" / raw view): its URL
and its full header list.

## Step 2 — Diff the app request against the Apidog request

Compare the two requests field by field and identify every difference. Report the
diff explicitly. The usual culprits, in order of likelihood for this stack:

1. **Missing / stripped `Host` header (most likely).** Valet routes by the `.test`
   Host. Apidog sends `Host: shamoapps.test`; the app may not. Note the known Dio
   pitfall (issue #1577): a `Host` placed in `BaseOptions.headers` is often dropped
   or overwritten by `dart:io`'s `HttpClient`. Confirm from the Step 1 logs whether
   `Host` actually leaves the app. If the response body was Valet HTML, this is
   almost certainly the cause.
2. **Wrong base URL / mode mismatch.** Apidog likely hits `http://shamoapps.test`
   directly (the Mac resolves `.test`); the app hits `10.0.2.2`, a LAN IP, or an
   ngrok URL. Verify the mode matches how the tunnel/server is actually running, and
   that `API_USE_NGROK` is set correctly (ngrok rewrites Host server-side, so in
   ngrok mode the app must **not** send its own `Host`; in direct-to-Valet mode it
   **must**).
3. **Missing `Accept: application/json`.** Without it, Laravel may return an HTML
   error page instead of a JSON envelope, which then trips the `body is String`
   branch.
4. **Missing/blank `Authorization`** on an authenticated route (token not persisted
   or not attached), producing a 401 whose body may differ from what you expect.
5. **Cart headers** absent on a cart/checkout call (`X-CART-ID` / `X-CART-SECRET`),
   producing a rejection.

## Step 3 — Confirm the root cause, then apply the matching fix

Only after Step 2 identifies the concrete difference, apply the fix that matches the
evidence — not a guess:

- **If `Host` is missing/stripped (direct-to-Valet mode):** set `Host` in the
  interceptor's `onRequest` (`options.headers['Host'] = AppConfig.valetHost`), not in
  `BaseOptions.headers`, and construct Dio with `preserveHeaderCase: true`. Re-run the
  logging interceptor and **verify from the logs that `Host: shamoapps.test` now
  actually leaves the app** — do not assume it did.
- **If in ngrok mode and `Host` is being sent by the app:** stop sending it (ngrok
  rewrites Host via `ngrok http --host-header=shamoapps.test 80`); the app-side Host
  should be attached only when `!AppConfig.useNgrok`.
- **If base URL/mode is wrong:** correct the `--dart-define` values for the device in
  use (emulator → `http://10.0.2.2`; physical phone → the Mac's LAN IP; off-LAN →
  the ngrok URL with `API_USE_NGROK=true`).
- **If `Accept` is missing:** ensure `Accept: application/json` is a default header.
- **If it is an auth/cart header issue:** fix the interceptor that should attach it,
  per `references/cart-and-auth-flow.md`.

## Step 4 — Harden the error surface (so this is never silent again)

Regardless of the specific cause, make the failure legible next time:

- In `error_mapper.dart`, when the body is a non-JSON String, detect the Valet/HTML
  case and return a **distinct, actionable** message (e.g.
  `ServerFailure('Backend routing error: received an HTML page, not JSON — check Host/base URL')`)
  instead of a generic `Server error`. Keep it out of user-facing copy if needed, but
  log the first line of the HTML so the cause is obvious in logs.
- Keep the logging interceptor available behind a debug flag (do not ship it always
  on) so this diff can be captured quickly in future.

## Constraints

- **Evidence before edits.** Do not modify networking code until Step 1–2 logs are
  captured and the concrete request diff is reported. State the confirmed root cause
  explicitly before applying a fix.
- **Do not blame or rewrite the error mapper** as the primary fix — it is correctly
  catching a non-JSON body. The defect is in what the app sends/receives.
- **Additive, minimal scope.** Touch only the networking/config code the evidence
  points to. Do not restructure unrelated code.
- Follow the project conventions in `PROJECT_STRUCTURE.md` / `CLAUDE.md` and the
  `shamo-api-integration` skill (interceptors in `core/network/interceptors/`,
  separate `refreshDio`, `AppConfig` for base URL/host/mode).
- Remove the temporary verbose logging (or gate it behind a debug flag) once the
  issue is resolved.

## What to report back

1. The captured app request (URL + headers) and response (status + body snippet).
2. The Apidog request (URL + headers).
3. The explicit diff and the **confirmed** root cause.
4. The fix applied, and a re-run log proving the request now succeeds (JSON envelope
   received, `meta.code` 200).
