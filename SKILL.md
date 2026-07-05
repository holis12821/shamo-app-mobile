---
name: shamo-api-integration
description: >-
  Use when integrating a REST endpoint from the Shamo backend into a Flutter app
  that follows Clean Architecture with the BLoC pattern. Trigger this whenever the
  task involves wiring a new API endpoint (auth, user, product, cart, checkout,
  transaction, or payment) end to end through the data, domain, and presentation
  layers, or when adding a data source, repository, use case, model, entity, or
  BLoC/Cubit that talks to the Shamo API. This skill encodes the project's layer
  boundaries, the `{ meta, data }` response envelope contract, the guest-cart
  session-header mechanism (X-CART-ID / X-CART-SECRET), Bearer token handling with
  refresh, and the Either/Failure error-handling convention. Do not use for pure UI
  work with no network call, or for backends other than Shamo.
---

# Shamo API Integration (Flutter · Clean Architecture · BLoC)

This skill defines how to integrate any Shamo backend endpoint into a Flutter
application that is already built on Clean Architecture with the BLoC pattern. It
exists to keep every new endpoint consistent with the existing layer boundaries,
the shared response contract, and the error-handling strategy, so that generated
code is predictable, testable, and free of the parsing and auth pitfalls this API
is prone to.

Read this file first. When a specific endpoint contract or edge case is needed,
open the matching file under `shamo_api_integration/`.

## When this skill applies

Apply this skill when the request is to integrate, extend, or fix an endpoint that
belongs to the Shamo API surface: authentication, user profile, product catalog,
cart, checkout, transactions, or payment callbacks. Do not apply it to work that
never touches the network, or to any other backend.

## Non-negotiable architectural rules

These rules take precedence over convenience. If a request seems to conflict with
one of them, stop and surface the conflict rather than silently working around it.

1. **Respect the dependency rule.** Dependencies point inward only:
   `presentation → domain ← data`. The domain layer must not import anything from
   the data or presentation layers, and must not know about Dio, JSON, or any
   framework type. Entities and use cases are pure Dart.

2. **Never return raw models or `Response` objects to the presentation layer.**
   The presentation layer consumes entities and use cases exclusively. Models
   (JSON-aware) live in `data/model/` and are converted to entities via their
   hand-written `map()` method before crossing the boundary — models do **not**
   extend entities in this project.

3. **Every repository method returns `Either<Failure, T>`.** No throwing across the
   repository boundary. Exceptions raised in a data source are caught in the
   repository implementation and converted into a typed `Failure`. Use cases and
   BLoCs consume the `Either`, never a raw exception.

4. **The API response envelope is `{ meta, data }` and must be parsed as such.**
   Every successful Shamo response wraps its payload:
   `meta` carries `{ code, status, message }`, and `data` carries the actual
   payload. Models parse `json['data']`, not the root object. See
   `shamo_api_integration/api-contract.md` for the exact shapes and the three different error
   shapes this API can return.

5. **Error responses are not uniform — handle three shapes defensively.** A failed
   call may return the standard envelope, or a nested `data.message` / `data.error`
   pair (see the 401 on register), or a bare JSON string on 500. Error parsing must
   never assume the success schema is present. Centralize this in one place (an
   error mapper / interceptor) rather than duplicating it per data source.

6. **Cart uses a confirmed guest-session mechanism — headers are required.** Cart
   and checkout endpoints identify a guest cart via `X-CART-ID` and `X-CART-SECRET`
   rather than the Bearer token. Per backend confirmation (overriding the source
   spec): both headers are **required** on every cart endpoint operating on an
   existing cart (read, add, update, delete, claim) — including update and delete,
   which the spec wrongly omitted the secret from — and `X-CART-ID` is a **single
   string**, not an array, on claim. The only endpoint without cart headers is
   `POST /api/cart` (create), which runs before a cart exists. Persist the cart's
   identifying values separately from the auth token, attach both headers via
   interceptor, and **fail fast with `CartSessionFailure`** if a required header is
   missing. After login, merge the guest cart via `POST /api/cart/claim`. See
   `shamo_api_integration/cart-and-auth-flow.md`.

7. **Auth tokens are managed centrally with refresh.** The access token is attached
   as `Authorization: Bearer <token>` by a single interceptor. On a 401 that
   indicates an expired token, attempt a refresh via `POST /api/refresh` once, then
   retry the original request. A failed refresh clears the session and surfaces an
   `AuthFailure`. Never scatter token-reading logic across data sources.

8. **Base URL and Host header are configuration and mode-aware.** The backend runs
   under Laravel Valet at `http://shamoapps.test`, which routes by the `.test` Host
   header that devices can't resolve. There are three access modes, switched by
   build flags only: emulator → `http://10.0.2.2`; physical phone on the same
   Wi-Fi → the Mac's LAN IP; any device off-LAN → an ngrok URL. Base URL comes from
   `--dart-define=API_BASE_URL`. The critical rule is **who sets `Host`**: in the
   two direct-to-Valet modes the app's interceptor attaches a constant
   `Host: shamoapps.test`; in ngrok mode it must **not** (ngrok rewrites the Host
   server-side via `ngrok http --host-header=shamoapps.test 80`). Drive this with a
   flag, e.g. `--dart-define=API_USE_NGROK=true`, so the Host interceptor is
   conditional. Any non-JSON body (Valet `404 - Not Found` HTML, or an ngrok host
   error) means the request never reached Laravel — treat it as a transport
   failure, never feed it to the envelope parser. See `shamo_api_integration/api-contract.md`
   → "Environment & base URL".

9. **Additive, minimally-scoped changes.** When extending an existing feature,
   follow the patterns already present in that feature's folders. Do not
   restructure working code, rename existing public members, or "improve"
   unrelated files as part of an endpoint integration.

## Target layer layout (this project — layer-first, not feature-first)

This project organizes by **layer first**, not by feature. Do not create a
`features/<x>/` tree. Place new code in the existing layer folders:

```
lib/
├── core/
│   ├── config/        app_config.dart          # AppConfig.baseUrl, useNgrok, valetHost
│   ├── di/            service_locator.dart     # get_it `sl`; register here
│   ├── error/         failures.dart            # Failure hierarchy (Equatable)
│   ├── network/       api_client.dart          # Dio factory + main instance
│   │                  error_mapper.dart        # DioException → Failure (3 shapes)
│   │                  interceptors/
│   │                    host_interceptor.dart  # Mode-aware Host header for Valet
│   │                    auth_interceptor.dart  # Bearer + single-flight refresh (refreshDio)
│   │                    cart_interceptor.dart  # X-CART-ID / X-CART-SECRET
│   ├── storage/       token_storage.dart, cart_storage.dart  # flutter_secure_storage
│   └── usecases/      usecase.dart             # UseCase<T, Params>, NoParams
├── domain/
│   ├── entity/        product.dart, user.dart, ...   # pure Dart (Equatable)
│   ├── repository/    <x>_repository.dart            # abstract contracts
│   └── usecase/       <verb>_<noun>.dart             # one class per action
├── data/
│   ├── model/         <x>_model.dart (+ .g.dart)     # @JsonSerializable + map()
│   ├── data_source/   <x>_remote_data_source.dart
│   └── repository/    <x>_repository_impl.dart       # Either, exception→Failure
├── presentation/
│   ├── screens/<name>_screen/
│   │   ├── bloc/      <name>_event.dart, <name>_state.dart, <name>_bloc.dart
│   │   └── view/      <name>_screen.dart (BlocProvider), <name>_view.dart (UI)
│   └── widgets/       shared widgets
└── routes/           app_route.dart                  # named routes
```

**Project conventions that override generic Clean-Architecture defaults:**

- **Models do NOT extend entities.** Each model is
  `@JsonSerializable(fieldRename: FieldRename.snake)` with generated
  `fromJson`/`toJson` (`.g.dart`) **and a hand-written `map()`** that returns the
  entity. Conversion is `Model.fromJson(json).map()`. Snake_case wire keys
  (`access_token`) map to camelCase Dart fields automatically via `fieldRename`.
- After adding/changing a model, run
  `dart run build_runner build --delete-conflicting-outputs`.
- **BLoC uses `flutter_bloc: ^7.0.0`, not Cubit.** Events are an `abstract`/`sealed`
  class extending `Equatable`. **State is a hierarchy of separate Equatable classes**
  under one base type (`Initial / Loading / Loaded / Error`). Use `abstract class` as
  the base for `flutter_bloc ^7` / Dart 2.x compatibility (the `sealed` keyword is
  Dart 3+; switch to it only if the project is on Dart 3+ and you want compiler
  exhaustiveness). Register all `on<Event>()` handlers in the BLoC constructor;
  handlers are private async methods. The view switches on the concrete state type
  (`state is HomeLoaded`).
- **Screen/View split:** `<name>_screen.dart` is a `BlocProvider` wrapper that
  creates the BLoC and fires the init event; `<name>_view.dart` is the UI that reads
  state via `BlocBuilder`/`BlocListener`. Keep BLoC creation out of the view.
- **Networking:** a main `Dio` wires `HostInterceptor` + `CartInterceptor` + `AuthInterceptor`; a
  **separate `refreshDio` with no interceptors** performs the token refresh to avoid
  recursive interception. `error_mapper.dart` maps all three error shapes.
- **DI:** register data source, repository, use case, and BLoC in
  `core/di/service_locator.dart` via `sl`, matching the existing registration style.
- **Failures** extend an Equatable `Failure` base: `ServerFailure`, `NetworkFailure`,
  `AuthFailure`, `ValidationFailure` (optional `fieldErrors`), `CartSessionFailure`.

## Required flow for integrating one endpoint

Follow this order. Each step names the layer and its single responsibility.

1. **Contract check.** Open `shamo_api_integration/api-contract.md`, confirm method, path,
   required headers (Bearer? cart headers?), request body, and the exact
   success/error shapes. Parse the payload from `json['data']`; read `pagination`
   from `meta` for list endpoints.

2. **Entity (`domain/entity/`).** Define or reuse a pure Dart entity (Equatable)
   with only the fields the app needs. No JSON, no `.g.dart`.

3. **Model (`data/model/`).** Create `<x>_model.dart` with
   `@JsonSerializable(fieldRename: FieldRename.snake)`, generated
   `fromJson`/`toJson`, and a hand-written **`map()`** returning the entity. Models
   do **not** extend entities. Run build_runner after.

4. **Repository contract (`domain/repository/`).** Add the abstract method returning
   `Either<Failure, Entity>` (list/void as appropriate).

5. **Remote data source (`data/data_source/`).** Implement the raw Dio call using
   the main `ApiClient`. Return the model (via `fromJson`) or throw on non-2xx. No
   `Either`, no swallowing.

6. **Repository implementation (`data/repository/`).** Call the data source in
   try/catch, convert `DioException` via `error_mapper.dart` into a typed `Failure`,
   call `model.map()` to produce the entity, and return `Either`. Only here do
   exceptions become failures.

7. **Use case (`domain/usecase/`).** One class per action extending
   `UseCase<ReturnType, Params>`, delegating to the repository.

8. **BLoC (`presentation/screens/<name>_screen/bloc/`).** A hierarchy of separate
   Equatable state classes (`Initial/Loading/Loaded/Error`) under an `abstract`
   base (or `sealed` on Dart 3+), an `abstract`/`sealed` event class, and handlers
   registered in the constructor. The BLoC calls the use case, folds the `Either`,
   and emits the concrete state class. It never touches Dio, models, or JSON.

9. **Dependency injection.** Register data source, repository, use case, and BLoC in
   `core/di/service_locator.dart` following the existing `sl` style.

10. **Tests.** Add unit tests for the model (`fromJson` then `map()` produces the
    right entity), the repository (success + each failure mapping), and the BLoC
    (state sequence on success and on failure).

## Error-handling contract

- Define a sealed/abstract `Failure` with concrete cases at minimum:
  `ServerFailure`, `NetworkFailure`, `AuthFailure`, `ValidationFailure`,
  `CartSessionFailure`.
- Map by transport and envelope: connectivity/timeout → `NetworkFailure`;
  401 (non-refreshable) → `AuthFailure`; 422-style field errors → `ValidationFailure`
  carrying the field messages; a missing required cart header (client-side) or a
  cart error returned by the backend (invalid/expired cart id) → `CartSessionFailure`;
  anything else 5xx or unparseable → `ServerFailure` with a safe default message.
  Cart headers are required (confirmed), so failing fast client-side before sending
  an incomplete cart request is correct.
- Extract a human-readable message from `meta.message` when present, falling back
  to `data.error` / `data.message`, then to a generic string. Never surface a raw
  exception or a bare `"string"` payload to the UI.
- **Guard against non-JSON bodies.** A Valet/nginx error can return HTML (e.g.
  `Valet - Not Found`) instead of the envelope. Before parsing, check the body is
  JSON; if it is HTML/text, map to `ServerFailure` (or `NetworkFailure` for a
  gateway/refused case) and never pass it to `fromJson`.

## Definition of done

An integration is complete only when: the dependency rule holds in every new file;
models use `@JsonSerializable(fieldRename: snake)` + `map()` (not `extends`);
the repository returns `Either` and converts errors via `error_mapper.dart`; the
BLoC uses separate Equatable state classes under an abstract/sealed base; auth and cart headers are
attached by their interceptors (not inline); refresh uses the separate `refreshDio`;
errors map to typed `Failure`s across all three response shapes; DI is registered in
`service_locator.dart`; `build_runner` has been run for new models; and the model,
repository, and BLoC each have passing unit tests. State any assumption explicitly
in the summary of work.

## Reference files

- `shamo_api_integration/api-contract.md` — per-endpoint contracts, the `{ meta, data }`
  envelope, `meta.pagination`, the three error shapes, and the confirmed auth /
  login / refresh payloads.
- `shamo_api_integration/cart-and-auth-flow.md` — the guest-cart header mechanism, the
  claim-on-login sequence, and the single-flight token-refresh algorithm (via
  `refreshDio`).
- `shamo_api_integration/layer-templates.md` — skeleton code matching this project's
  conventions (entity, `@JsonSerializable` model with `map()`, data source,
  repository impl, `UseCase`, sealed-style BLoC, interceptors).

The repository's own `PROJECT_STRUCTURE.md` and `CLAUDE.md` are the authoritative
source for folder layout, dependencies, and conventions; this skill aligns with
them. If they ever diverge from this skill, follow the repository files and flag the
difference.
