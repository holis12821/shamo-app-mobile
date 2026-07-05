# Task: Integrate the Shamo API into the Flutter App (Clean Architecture + BLoC)

You are a senior Flutter engineer working in an existing, running application that
already follows Clean Architecture with the BLoC pattern. Your job is to integrate
the Shamo backend API into this project **incrementally and safely**, one endpoint
group at a time, without disturbing working code.

Before writing any code, load and follow the `shamo-api-integration` skill, and
read the repository's `PROJECT_STRUCTURE.md` and `CLAUDE.md` — they are the
authoritative source for folder layout, dependencies, and conventions. This task
file tells you *what* to build; the skill and its `references/` tell you *how*.

## Ground rules

1. **Match the existing project conventions exactly** (from `PROJECT_STRUCTURE.md`):
   layer-first folders (`domain/entity`, `data/model`, `data/data_source`,
   `data/repository`, `presentation/screens/<name>_screen/{bloc,view}`); models are
   `@JsonSerializable(fieldRename: FieldRename.snake)` with a `map()` to the entity
   and do **not** extend entities; BLoC is `flutter_bloc ^7` with a **hierarchy of
   separate Equatable state classes** (`Initial/Loading/Loaded/Error`) under an
   `abstract` base (use `sealed` only if the project is on Dart 3+), **not** Cubit;
   errors use `dartz Either` +
   the `Failure` hierarchy; DI via `get_it` (`sl`) in `service_locator.dart`. Run
   `dart run build_runner build --delete-conflicting-outputs` after touching models.
2. **Additive, minimally-scoped changes only.** Touch only the files a given
   endpoint requires. Do not rename existing public members or "improve" unrelated
   code. Extend the existing `core/network` `ApiClient`; do not add a second client.
3. **Surface conflicts, don't silently work around them.** If a skill rule
   contradicts something already in the repo, follow the repo and flag it.
4. **Surface every assumption**, marking derived code `// TODO: verify against live
   API`. (Most contracts are now confirmed against the live API — see
   `references/api-contract.md`.)
5. **Never commit secrets or placeholder hosts.** Base URL comes from
   `--dart-define=API_BASE_URL` via `AppConfig.baseUrl`.

## Recommended implementation order

Integrate in this sequence so that dependencies are satisfied as you go. Complete,
test, and stop at the end of each phase for review before starting the next.

### Phase 1 — Networking & auth foundation
- Establish/extend the Dio client in `core/network`. Support three access modes by
  build flags only: emulator → `http://10.0.2.2`; physical phone (same Wi-Fi) → the
  Mac's LAN IP; any device off-LAN → an ngrok URL. Base URL from
  `--dart-define=API_BASE_URL`. The Host interceptor is **mode-aware**: attach a
  constant `Host: shamoapps.test` in the two direct-to-Valet modes, but **skip it**
  when `--dart-define=API_USE_NGROK=true` (ngrok rewrites the Host server-side via
  `ngrok http --host-header=shamoapps.test 80`). Both the Valet host and the ngrok
  flag live in config.
- Add interceptors for three concerns: (a) attach `Authorization: Bearer` for
  authenticated routes,
  (b) attach the **required** cart headers `X-CART-ID` **and** `X-CART-SECRET` to
  all cart/checkout routes that operate on an existing cart (read, add, update,
  delete, claim) — fail fast with `CartSessionFailure` if a required header is
  missing; the only exception is `POST /api/cart` (create), which carries none,
  (c) a central error mapper that handles all three response shapes.
- Implement the token **refresh-and-retry with single-flight lock** exactly as
  described in `references/cart-and-auth-flow.md`.
- Implement the `Failure` hierarchy and the `UseCase` base contract.

### Phase 2 — Auth feature
- Endpoints: `POST /api/auth/register`, `POST /api/auth/login`,
  `POST /api/auth/logout`, `POST /api/refresh`.
- Build one shared `AuthResponseModel` (access_token, refresh_token, token_type,
  user) used by login and register, plus a `UserModel` (note `roles` is a **String**
  like `"USER"`, not a list; several fields nullable). Both are
  `@JsonSerializable(fieldRename: snake)` with `map()`.
- **Refresh is confirmed:** `POST /api/refresh` (Bearer = the refresh token) returns
  `{ access_token, token_type }` only — no `refresh_token` (not rotated), no `user`.
  The interceptor saves the new access token, keeps the existing refresh token, and
  retries once. Use the separate `refreshDio`.
- On successful login/register, if a guest cart exists, trigger
  `POST /api/cart/claim` (see Phase 5 dependency note).
- Auth BLoC follows the sealed-style convention: separate Equatable state classes
  under an abstract base — e.g. `AuthInitial`, `AuthLoading`, `Authenticated(user)`,
  `Unauthenticated`, `AuthError(message)` — not a single state with `copyWith`.

### Phase 3 — User feature
- Endpoints: `GET /api/user`, `POST /api/user` (update profile).
- Reuse the user entity/model from Phase 2.

### Phase 4 — Product feature
- Endpoints: `GET /api/categories`, `GET /api/product/products` (with
  `limit`/`categories`/`name`/`page` query params + pagination), and
  `GET /api/product/products/{item}`.
- Model the product, category, gallery, pagination, and the `formatted.price`
  field. Confirmed against the live API: the list is `data.products` (not `items`),
  and `pagination`/`filters` live inside `meta`, not `data`. `filters` is an empty
  array in practice — model defensively.

### Phase 5 — Cart feature
- Endpoints: `POST /api/cart`, `GET /api/cart`, `POST /api/cart/items`,
  `PUT /api/cart/items/{item}`, `DELETE /api/cart/items/{item}`,
  `POST /api/cart/claim`.
- Implement the guest-cart create-and-persist logic and header attachment. Cart
  headers are **required** (confirmed) — both `X-CART-ID` and `X-CART-SECRET` on
  every cart endpoint operating on an existing cart, including update and delete.
  Verify the create-cart response keys before persisting; do not assume `id`/`secret`
  naming.
- Wire the claim call invoked by Phase 2. (If Phase 5 storage is not yet present
  when doing Phase 2, stub the claim trigger behind an interface and implement it
  here.) `X-CART-ID` on claim is a **single string**, not an array.

### Phase 6 — Checkout & Transaction features
- Checkout: `GET /api/order/checkout`, `POST /api/order/checkout` (body:
  `{ address }`), both requiring cart-session headers.
- Transaction: `GET /api/transaction/transactions`,
  `GET /api/transaction/transactions/{order_number}`.

### Payment (do not implement a client call)
- `POST /api/payments/midtrans/callback` is a Midtrans server-to-server webhook,
  not a mobile client call. Do **not** build a client integration for it. If
  payment status is needed in-app, poll the transaction detail endpoint. State this
  clearly if asked to "integrate payment."

## Per-endpoint checklist (repeat for each)

For every endpoint, produce, in this order: entity → model (parse `json['data']`)
→ repository contract → remote data source → repository impl (exceptions → typed
`Failure`, return `Either`) → use case → BLoC (events/states) → DI registration →
unit tests (model, repository, BLoC).

## Definition of done (per phase)

- Dependency rule holds in all new files (`presentation → domain ← data`).
- Repositories return `Either<Failure, T>`; no exceptions cross the boundary.
- Models parse the `{ meta, data }` envelope; error mapping covers all three
  response shapes.
- Auth and cart headers are attached by interceptors, never inline in data sources.
- DI registrations added following the existing style.
- Unit tests pass for model, repository, and BLoC.
- A short written summary lists: files added/changed, every assumption made where
  the spec was empty, and any deviation from the skill forced by existing project
  conventions.

## What to hand back after each phase

1. The diff (files created/modified).
2. The assumptions list.
3. The test results.
4. Any open questions that block the next phase.

Then stop and wait for review before continuing.
