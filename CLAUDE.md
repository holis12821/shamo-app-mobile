# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
# Run the app (API_BASE_URL is required via dart-define)
flutter run --dart-define=API_BASE_URL=https://your-host.example.com

# For direct-to-Valet modes (emulator / LAN), Host header is auto-attached.
# For ngrok mode, disable the Host header:
flutter run --dart-define=API_BASE_URL=https://xxxx.ngrok-free.dev --dart-define=API_USE_NGROK=true

# Code generation (models use json_serializable)
dart run build_runner build --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n

# Analyze
flutter analyze

# Run all tests
flutter test

# Run a single test
flutter test test/widget_test.dart
```

## Project Structure

For the full project structure, architecture diagrams, layer details, BLoC conventions, networking architecture, and data flow, see [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md).

## API Integration Skill

For the complete integration methodology (per-endpoint checklist, layer templates, error-handling contract, and definition of done), see [SKILL.md](SKILL.md). Reference files for endpoint contracts, cart/auth flows, and code skeletons live in `shamo_api_integration/`.

## Architecture

Clean Architecture with BLoC pattern. Three layers:

- **domain/** — Entities (pure Dart, Equatable) in `domain/entity/`
- **data/** — Models in `data/model/`, use `@JsonSerializable(fieldRename: FieldRename.snake)` with a `map()` method to convert to the corresponding entity (models do NOT extend entities)
- **presentation/** — Screens in `presentation/screens/<name>/` with `bloc/` and `view/` subdirectories; shared widgets in `presentation/widgets/`

### Core Infrastructure (`lib/core/`)

- **config/** — `AppConfig.baseUrl` from `--dart-define=API_BASE_URL`, `AppConfig.useNgrok` from `--dart-define=API_USE_NGROK`, `AppConfig.valetHost` = `shamoapps.test`
- **di/** — `get_it` service locator (`sl`), initialized in `main()` via `setupServiceLocator()`
- **network/** — Dio-based `ApiClient` with three interceptors: `HostInterceptor` (mode-aware Host header for Valet), `CartInterceptor` (X-CART-ID/X-CART-SECRET), `AuthInterceptor` (Bearer + single-flight refresh via separate `refreshDio`). `preserveHeaderCase: true` set on BaseOptions. `error_mapper.dart` handles all three Shamo API error shapes.
- **storage/** — `TokenStorage` and `CartStorage` using `flutter_secure_storage`
- **error/** — `Failure` hierarchy (Server, Network, Auth, Validation, CartSession) used with `dartz Either`
- **usecases/** — `UseCase<T, Params>` base class returning `Future<Either<Failure, T>>`
- **theme/** — Colors, dimensions, text styles, asset paths

### Key Patterns

- **BLoC** (not Cubit) — `flutter_bloc: ^7.0.0` with `bloc_concurrency`. Two state conventions coexist:
  - **API-connected features**: state hierarchy of separate Equatable classes (`Initial/Loading/Loaded/Error`) under an `abstract` base. Views switch on concrete type (`state is HomeLoaded`).
  - **Local-only features** (e.g., chat): single state class with `copyWith`.
- **Routing** — Named routes defined in `lib/routes/app_route.dart`
- **Localization** — `flutter gen-l10n` with ARB files; supports `en` and `id`
- **DI** — Register new dependencies in `core/di/service_locator.dart`

### API Integration Plan

Detailed API specs live in `shamo_api_integration/`. The integration is being built in phases:

- Phase 1 (done): Core networking, auth interceptors, DI, storage
- Phases 2-6: Auth, User, Product, Cart, Checkout features

Key API rules:

- `POST /api/payments/midtrans/callback` is a server webhook — do NOT implement a client call
- Cart endpoints require both `X-CART-ID` and `X-CART-SECRET` headers (except `POST /api/cart`)
- Refresh token is sent as Bearer on `POST /api/refresh` (not the access token)
- Refresh response returns `{ access_token, token_type }` only — no `refresh_token` (not rotated), no `user`
- Product list lives at `data.products` (not `data.items`); pagination is in `meta`, not `data`
- User `roles` is a string (e.g. `"USER"`), not an array