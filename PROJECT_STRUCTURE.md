# Shamo App Mobile — Project Structure

Shamo is a Flutter e-commerce application built with **Clean Architecture** and **BLoC** as the event-driven state management pattern. The codebase separates concerns into three main layers — Domain, Data, and Presentation — plus a Core layer for cross-cutting infrastructure.

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│         (Screens, BLoC, Widgets, Routing)                │
│                                                         │
│   Event ──► BLoC ──► State ──► View (rebuild)           │
└──────────────────────┬──────────────────────────────────┘
                       │ depends on
┌──────────────────────▼──────────────────────────────────┐
│                     Domain Layer                         │
│             (Entities, Use Cases, Repository             │
│              contracts — pure Dart, no Flutter)          │
└──────────────────────┬──────────────────────────────────┘
                       │ implements
┌──────────────────────▼──────────────────────────────────┐
│                      Data Layer                          │
│         (Models, Data Sources, Repository impls)         │
│                                                         │
│   API / local ──► Model ──► .map() ──► Entity           │
└──────────────────────┬──────────────────────────────────┘
                       │ uses
┌──────────────────────▼──────────────────────────────────┐
│                      Core Layer                          │
│      (DI, Networking, Storage, Error handling,           │
│       Theme, Configuration, Base Use Case)               │
└─────────────────────────────────────────────────────────┘
```

**Dependency rule:** outer layers depend inward. Presentation depends on Domain; Data implements Domain; Core is shared by all layers.

---

## Directory Structure

```
lib/
├── main.dart                         # Entry point — initializes DI, runs app
│
├── core/                             # Cross-cutting concerns
│   ├── config/
│   │   └── app_config.dart           # API base URL, useNgrok, valetHost (via --dart-define)
│   ├── di/
│   │   └── service_locator.dart      # get_it registration (sl)
│   ├── error/
│   │   └── failures.dart             # Failure hierarchy (Equatable)
│   ├── network/
│   │   ├── api_client.dart           # Dio factory with interceptors
│   │   ├── error_mapper.dart         # DioException → typed Failure
│   │   └── interceptors/
│   │       ├── host_interceptor.dart   # Mode-aware Host header for Valet
│   │       ├── auth_interceptor.dart   # Bearer token + single-flight refresh
│   │       └── cart_interceptor.dart   # X-CART-ID / X-CART-SECRET headers
│   ├── storage/
│   │   ├── token_storage.dart        # Access + refresh token (secure storage)
│   │   └── cart_storage.dart         # Cart ID + secret (secure storage)
│   ├── theme/
│   │   ├── custom_app_theme.dart     # Color palette
│   │   ├── custom_text_theme.dart    # Typography styles
│   │   ├── custom_app_dimensions.dart # Spacing & sizing constants
│   │   └── custom_assets.dart        # Asset path constants
│   └── usecases/
│       └── usecase.dart              # UseCase<T, Params> base + NoParams
│
├── domain/                           # Business rules (pure Dart)
│   ├── entity/
│   │   ├── product.dart              # Product entity (Equatable)
│   │   ├── user.dart                 # User entity (Equatable)
│   │   ├── category.dart             # Category entity (Equatable)
│   │   ├── gallery.dart              # Gallery entity (Equatable)
│   │   └── chat.dart                 # Chat entity with factory constructors
│   ├── repository/                   # Repository contracts (abstract classes)
│   └── usecase/                      # Concrete use cases
│
├── data/                             # External data access
│   ├── model/
│   │   ├── product_model.dart        # @JsonSerializable + map() → Product (includes FormattedModel)
│   │   ├── product_model.g.dart      # Generated serialization
│   │   ├── user_model.dart           # @JsonSerializable + map() → User
│   │   ├── user_model.g.dart
│   │   ├── category_model.dart       # @JsonSerializable + map() → Category
│   │   ├── category_model.g.dart
│   │   ├── gallery_model.dart        # @JsonSerializable + map() → Gallery
│   │   ├── gallery_model.g.dart
│   │   ├── auth_response_model.dart  # Shared by login & register (tokens + user)
│   │   ├── auth_response_model.g.dart
│   │   ├── chat_model.dart           # @JsonSerializable + map() → Chat
│   │   └── chat_model.g.dart
│   ├── data_source/                  # Remote/local data source implementations
│   └── repository/                   # Repository implementations
│
├── presentation/                     # UI layer
│   ├── screens/
│   │   ├── sign_in_screen/
│   │   │   ├── bloc/                 # (placeholder for auth BLoC)
│   │   │   └── view/
│   │   │       └── sign_in_screen.dart
│   │   ├── sign_up_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       └── sign_up_screen.dart
│   │   ├── main_screen/              # Tab host (Home, Chat, Wishlist, Profile)
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       └── main_screen.dart
│   │   ├── home_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       └── home_screen.dart
│   │   ├── chat_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       └── chat_screen.dart
│   │   ├── detail_chat_screen/
│   │   │   ├── bloc/
│   │   │   │   ├── chat_event.dart   # Sealed event class (Equatable)
│   │   │   │   ├── chat_state.dart   # Single state with copyWith
│   │   │   │   └── chat_bloc.dart    # Event handlers registered in constructor
│   │   │   └── view/
│   │   │       ├── detail_chat_screen.dart  # BlocProvider wrapper
│   │   │       └── detail_chat_view.dart    # UI that reads BLoC state
│   │   ├── edit_profile_screen/
│   │   │   ├── bloc/
│   │   │   │   ├── edit_profile_event.dart
│   │   │   │   ├── edit_profile_state.dart
│   │   │   │   └── edit_profile_bloc.dart
│   │   │   └── view/
│   │   │       ├── edit_profile_screen.dart
│   │   │       └── edit_profile_view.dart
│   │   ├── product_detail_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       ├── product_detail_screen.dart
│   │   │       └── product_detail_view.dart
│   │   ├── cart_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       ├── cart_screen.dart
│   │   │       ├── cart_view.dart
│   │   │       └── cart_item.dart
│   │   ├── wish_list_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       └── wish_list_screen.dart
│   │   ├── checkout_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       ├── checkout_screen.dart
│   │   │       └── checkout_view.dart
│   │   ├── checkout_success_screen/
│   │   │   ├── bloc/
│   │   │   └── view/
│   │   │       ├── checkout_success_screen.dart
│   │   │       └── checkout_success_view.dart
│   │   └── profile_screen/
│   │       ├── bloc/
│   │       └── view/
│   │           └── profile_screen.dart
│   └── widgets/                      # Shared / reusable widgets
│       ├── categories_widget.dart
│       ├── product_card.dart
│       ├── product_item_widget.dart
│       ├── product_new_arrivals.dart
│       ├── product_preview_widget.dart
│       ├── popular_products_widgets.dart
│       ├── new_arrivals_widget.dart
│       ├── header_widget.dart
│       ├── chat_bubble_widget.dart
│       ├── item_chat_widget.dart
│       ├── send_button_widget.dart
│       ├── wishlist_card_widget.dart
│       ├── checkout_card.dart
│       ├── address_detail_widget.dart
│       ├── payment_summary_widget.dart
│       ├── profile_avatar_widget.dart
│       ├── custom_bottom_bar_widget.dart
│       ├── animated_circle_close_button_widget.dart
│       ├── dialog_information.dart
│       └── dialog_loading.dart
│
├── routes/
│   └── app_route.dart                # Named route map
│
├── helper/
│   ├── sound_helper.dart             # Audio playback utility
│   └── utils/
│       ├── id_generator.dart         # Unique ID generation
│       ├── error_mapper.dart         # Legacy/UI error mapping
│       └── size_config/
│           └── size_config.dart      # Responsive sizing
│
└── src/generated/
    └── i18n/                         # Auto-generated localization (en, id)
        ├── app_localizations.dart
        ├── app_localizations_en.dart
        └── app_localizations_id.dart
```

---

## Layer Details

### 1. Core Layer (`lib/core/`)

Infrastructure shared across all layers. Nothing here knows about specific features.

| Module | Responsibility |
|---|---|
| **config** | `AppConfig.baseUrl` via `--dart-define=API_BASE_URL=...`, `AppConfig.useNgrok` via `--dart-define=API_USE_NGROK=true`, `AppConfig.valetHost` = `shamoapps.test`. |
| **di** | `get_it` service locator. The global accessor is `sl`. Called once in `main()` via `setupServiceLocator()`. All singletons (storage, Dio) are registered here. |
| **error** | `Failure` abstract base (Equatable) with subtypes: `ServerFailure`, `NetworkFailure`, `AuthFailure`, `ValidationFailure` (includes optional `fieldErrors` map), `CartSessionFailure`. Used with `dartz Either<Failure, T>` throughout the data and domain layers. |
| **network** | `ApiClient` — Dio factory (`preserveHeaderCase: true`) that wires three interceptors (`HostInterceptor` → `CartInterceptor` → `AuthInterceptor`) and a separate `refreshDio` (no interceptors) for token refresh. `HostInterceptor` attaches `Host: shamoapps.test` in direct-to-Valet modes, skipped when `useNgrok` is true. `error_mapper.dart` converts `DioException` to the appropriate `Failure` subtype, handling three distinct Shamo API error shapes. |
| **storage** | `TokenStorage` and `CartStorage` — thin wrappers around `flutter_secure_storage` for persisting auth tokens and cart session credentials. |
| **theme** | Design tokens: color palette (`CustomAppTheme`), typography (`CustomTextTheme`), spacing/sizing constants (`CustomAppDimensions`), asset paths (`CustomAssets`). |
| **usecases** | `UseCase<T, Params>` — abstract class with `Future<Either<Failure, T>> call(Params params)`. `NoParams` sentinel for parameterless use cases. |

### 2. Domain Layer (`lib/domain/`)

Pure Dart business logic with no Flutter imports.

- **entity/** — Plain Dart classes representing core business objects (`Product`, `User`, `Chat`). Some use `Equatable` for value equality; `Chat` uses factory constructors (`Chat.message()`, `Chat.product()`) for variant types.
- **repository/** — Abstract repository contracts (interfaces) that define data operations the domain needs. Implemented by the Data layer.
- **usecase/** — Concrete use case classes extending the base `UseCase<T, Params>`. Each encapsulates a single business action.

### 3. Data Layer (`lib/data/`)

Handles external data (API, local storage) and maps raw data into domain entities.

- **model/** — Annotated with `@JsonSerializable(fieldRename: FieldRename.snake)`. Each model has:
  - `fromJson()` / `toJson()` — generated by `json_serializable` (`.g.dart` files)
  - `map()` — manual conversion from Model → Entity (models do **not** extend entities)
- **data_source/** — Remote and local data source implementations (API calls via Dio, local caching).
- **repository/** — Concrete implementations of domain repository contracts. Orchestrate data sources, handle errors, and return `Either<Failure, T>`.

**Code generation:** after changing any model, run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Presentation Layer (`lib/presentation/`)

Flutter UI with BLoC-driven state management.

#### Screen Structure Convention

Every screen follows a consistent two-part structure inside its own directory:

```
<feature_name>_screen/
├── bloc/
│   ├── <feature>_event.dart    # Events (sealed/abstract class, Equatable)
│   ├── <feature>_state.dart    # State hierarchy (see below)
│   └── <feature>_bloc.dart     # BLoC (event handlers registered in constructor)
└── view/
    ├── <feature>_screen.dart   # BlocProvider wrapper — creates BLoC, fires init event
    └── <feature>_view.dart     # Stateless UI — consumes state via BlocBuilder/BlocListener
```

**Screen** (`*_screen.dart`) — wraps the view in a `BlocProvider`, creates the BLoC instance, and dispatches the initial loading event:
```dart
class DetailChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc()..add(LoadInitialMessages()),
      child: const DetailChatView(),
    );
  }
}
```

**View** (`*_view.dart`) — the actual UI. Reads BLoC state through `BlocBuilder` / `context.read()` / `context.watch()`. Contains no BLoC creation logic.

#### BLoC Pattern

- Uses `flutter_bloc: ^7.0.0` with **Bloc** (not Cubit) for explicit event-driven flow.
- **Events** — `sealed` or `abstract` class extending `Equatable`. Each event is a concrete subclass.
- **State** — two conventions coexist in this project:
  - **API-connected features** (edit profile, future auth/product/cart): a hierarchy of separate Equatable classes (`Initial`, `Loading`, `Loaded`, `Error`) under an `abstract` base (or `sealed` on Dart 3+). Views switch on concrete type (`state is HomeLoaded`).
  - **Local-only features** (chat): a single `Equatable` class with `copyWith()` and `factory State.initial()`.
  - For **new API integrations**, always use the state hierarchy pattern.
- **BLoC** — extends `Bloc<Event, State>`. All `on<Event>()` handlers are registered in the constructor. Handlers are private async methods.
- `bloc_concurrency` is available for advanced event transformer strategies (e.g., `droppable`, `restartable`).

#### Shared Widgets (`lib/presentation/widgets/`)

Reusable UI components used across multiple screens — product cards, chat bubbles, dialogs, bottom navigation bar, etc.

---

## Routing

Named routes are defined in `lib/routes/app_route.dart` as a static `Map<String, WidgetBuilder>`:

| Route | Screen |
|---|---|
| `/` | Sign In |
| `/sign-up` | Sign Up |
| `/home` | Main (tab host) |
| `/detail-chat` | Detail Chat |
| `/edit-profile` | Edit Profile |
| `/product` | Product Detail |
| `/cart` | Cart |
| `/checkout` | Checkout |
| `/checkout-success` | Checkout Success |

Navigation uses `Navigator.pushNamed(context, '/route')`.

---

## Networking Architecture

```
App Code
  │
  ▼
 Dio (main instance, preserveHeaderCase: true)
  │
  ├── HostInterceptor   ── attaches Host: shamoapps.test (direct-to-Valet modes)
  │                        skipped when AppConfig.useNgrok is true
  │
  ├── CartInterceptor   ── attaches X-CART-ID + X-CART-SECRET
  │                        (skips POST /api/cart; fails fast if headers missing)
  │
  └── AuthInterceptor   ── attaches Bearer token on all requests
       │                    (skips /register, /login, /refresh)
       │
       └── on 401 ──► single-flight refresh via refreshDio
                       (separate Dio instance, no interceptors)
                       retry original request once with new token
```

Error responses from the API are normalized through `error_mapper.dart`, which handles three Shamo API error shapes and maps them to the `Failure` hierarchy.

---

## Localization

- ARB files live in `lib/l10n/`
- Generated output goes to `lib/src/generated/i18n/`
- Supported locales: `en`, `id`
- Regenerate with: `flutter gen-l10n`

---

## Key Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter_bloc` | ^7.0.0 | BLoC state management |
| `bloc_concurrency` | ^0.1.0 | Event transformer strategies |
| `equatable` | ^2.0.7 | Value equality for entities, events, states |
| `dio` | ^5.4.0 | HTTP client |
| `dartz` | ^0.10.1 | `Either<Failure, T>` for error handling |
| `get_it` | ^7.6.7 | Dependency injection |
| `flutter_secure_storage` | ^9.2.2 | Secure token/cart session storage |
| `json_annotation` | ^4.9.0 | Model serialization annotations |
| `json_serializable` | ^6.9.5 | Code generation for JSON (dev) |
| `build_runner` | ^2.5.3 | Code generation runner (dev) |
| `google_fonts` | ^6.2.1 | Typography |
| `flutter_svg` | ^2.0.10+1 | SVG asset rendering |
| `carousel_slider` | ^5.1.1 | Image carousels |

---

## Data Flow Summary

```
User interaction
      │
      ▼
  View dispatches Event
      │
      ▼
  BLoC handles Event
      │
      ▼
  UseCase.call(params)
      │
      ▼
  Repository (contract in domain, impl in data)
      │
      ▼
  DataSource → Dio (with interceptors) → Shamo API
      │
      ▼
  Response → Model.fromJson() → Model.map() → Entity
      │
      ▼
  Either<Failure, Entity> returned up the chain
      │
      ▼
  BLoC emits new State
      │
      ▼
  View rebuilds via BlocBuilder
```
