# Shamo API Contract Reference

This file is the source of truth for endpoint contracts when integrating the Shamo
API. Load it during step 1 (contract check) of the integration flow. Where the
original spec showed an empty `{}` body, the shape below is derived from the
fully-specified endpoints that share the same envelope; those derivations are
marked **(derived)** and must be verified against the live API before release.

## The response envelope

Every response is expected to follow:

```jsonc
{
  "meta": { "code": 200, "status": "success", "message": "..." },
  "data": { /* payload */ }
}
```

- Models parse `json['data']`. Never parse the root object as the payload.
- `meta.message` is the primary source for user-facing messages. Read it; never
  hardcode messages (they have already drifted from the spec — e.g. product list
  returns an English message the spec wrote in Indonesian).
- **List endpoints put `pagination` (and `filters`) inside `meta`, not `data`.**
  Confirmed on the product list: `meta.pagination = { current_page, last_page,
  per_page, total, has_more }` and `meta.filters` (an array, often empty). Read
  pagination from `meta`.

## The three error shapes (handle all)

1. **Standard envelope error** — same `meta`, `status: "error"`, `data` may be null
   or an object.
2. **Nested auth error** (seen on 401 register): `data` contains its own
   `message` and `error` strings, e.g. a validation summary. Extract from
   `data.error` / `data.message` here.
3. **Bare string on 500** — the body is a raw JSON string, not an object. Parsing
   must not assume an object; treat as `ServerFailure` with a generic message.

## Authentication (`Shamo Apps/Auth`)

### POST /api/auth/register
- Body: `name`, `email`, `username`, `password`, `phone` (all strings).
- 200 `data`: `access_token`, `refresh_token`, `token_type` (`"Bearer"`), and a
  nested `user` object with the same shape confirmed on login (see below):
  `roles` is a **string** not an array; `email_verified_at`,
  `two_factor_confirmed_at`, `current_team_id`, `profile_photo_path` are nullable;
  `profile_photo_url` is always present. Model the user once and share it.
- 401 `data`: `{ message, error }` (error shape #2).
- 500: bare string (error shape #3).

### POST /api/auth/login
- Body: `email`, `password`.
- **Confirmed against the live API.** Success returns the `{ meta, data }` envelope
  with `meta.message` = `"User successfully logged in"` and `data`:
  - `access_token` (string), `refresh_token` (string), `token_type` (`"Bearer"`),
    and a `user` object.
  - `user`: `id` (int), `name`, `email`, `username`, `phone` (strings),
    `roles` — **a string** (e.g. `"USER"`), NOT an array; do not model as `List`.
    Nullable fields: `email_verified_at`, `two_factor_confirmed_at`,
    `current_team_id`, `profile_photo_path`. Always present: `created_at`,
    `updated_at`, `profile_photo_url` (falls back to a ui-avatars URL).
- Model one shared auth response (tokens + user) and reuse it for register.

### POST /api/auth/logout
- Headers: `Accept`, `Authorization`. No body. 200 envelope only. On success,
  clear the stored session (tokens and cart credentials).

### POST /api/refresh
- Headers: `Authorization: Bearer <refresh_token>` (the **refresh** token, not the
  access token), `Accept`, `Content-Type`.
- **Confirmed against the live API.** Success returns `meta.message` =
  `"Token refreshed"` and `data` = **`{ access_token, token_type }` only**:
  - Returns a new `access_token` and `token_type: "Bearer"`.
  - **No `refresh_token`** — the refresh token is NOT rotated; keep reusing the
    stored one.
  - **No `user`** — refresh does not return the user object.
- Interceptor behaviour: on success, persist the new `access_token` and retry the
  original request. Do **not** overwrite the stored refresh token (none is
  returned). Do not expect a user. This resolves the earlier uncertainty.

## User (`Shamo Apps/User`)

### GET /api/user
- Headers: `Accept`, `Authorization`, `Content-Type`. 200 body empty in spec.
  **(derived)** Expect the `user` object inside `data`; reuse the user model from
  auth.

### POST /api/user  (update profile)
- Body: `name`, `email`, `username`. 200 body empty in spec. **(derived)** Expect
  the updated `user` object inside `data`.

## Product (`Shamo Apps/Product`)

### GET /api/categories
- 200 body empty in spec. **(derived)** Expect `data` to contain a list of
  categories (`id`, `name`, timestamps), matching the nested `category` object seen
  in Product List.

### GET /api/product/products
- Query: `limit`, `categories`, `name`, `page` (all optional strings).
- **Confirmed against the live API** (the original spec was wrong/incomplete here):
  - The product list lives under **`data.products`** — NOT `data.items`. Parse
    `json['data']['products']`.
  - `pagination` sits inside **`meta`**, not `data`:
    `meta.pagination = { current_page, last_page, per_page, total, has_more }`.
    Read pagination from `meta`, not from the payload.
  - `filters` is inside `meta` and is an **empty array `[]`** in practice, not an
    object. Model it defensively (tolerate `[]` or an object); do not assume
    `{ limit, page }`.
  - `meta.message` observed as `"Product list retrieved successfully"` (the spec's
    Indonesian message is stale). Never hardcode messages; read `meta.message`.
- Product fields (confirmed): `id`, `name`, `price` (int), `description` (HTML
  string), `tags` (nullable), `categories_id`, `deleted_at` (nullable),
  `created_at`, `updated_at`, `formatted.price` (localized string, e.g.
  `"Rp 1.070.490"`), `category` (object), `galleries` (array of
  `{ id, products_id, url, deleted_at, created_at, updated_at }`).
- Keep `formatted` in the model layer; expose it to the domain only if the UI needs
  the pre-formatted price.

### GET /api/product/products/{item}
- Path: `item`. 200 body empty in spec. **(derived)** Expect a single product
  object inside `data`, same shape as one Product List item.

## Transaction (`Shamo Apps/Transaction`)

### GET /api/transaction/transactions
- Headers: `Accept`, `Authorization`, `Content-Type`. 200 body empty in spec.
  **(derived)** Expect a list of transactions inside `data` (likely paginated).

### GET /api/transaction/transactions/{order_number}
- Path: `order_number` (required). Headers include `Authorization`. 200 body empty
  in spec. **(derived)** Expect a single transaction detail inside `data`.

## Checkout (`Shamo Apps/Checkout`)

### GET /api/order/checkout
- Headers: `Authorization`, `X-CART-ID`, `X-CART-SECRET`. Returns the checkout
  summary for the current cart. Requires cart-session headers — see
  `cart-and-auth-flow.md`.

### POST /api/order/checkout
- Body: `{ "address": "..." }` (required). Headers: `Authorization`, `X-CART-ID`,
  `X-CART-SECRET`. Submits the checkout.

## Cart (`Shamo Apps/Cart`)

> **Confirmed by the backend team — these override the source spec.** The original
> spec was incomplete/incorrect on three points, now resolved:
> 1. Cart headers are **required**, not optional. The spec's `Required: no` is
>    wrong. Treat `X-CART-ID` / `X-CART-SECRET` as mandatory on every cart endpoint
>    that operates on an existing cart.
> 2. `PUT` (update) and `DELETE` **do require `X-CART-SECRET`.** The spec omitted
>    it; add it. All cart mutations carry both headers.
> 3. `X-CART-ID` on claim is a **single string**, not an array. The spec's
>    `array[string]` is wrong; a claim targets one cart.
>
> The guest-cart session design is therefore confirmed, not merely inferred. The
> interceptor may fail fast with `CartSessionFailure` when a required header is
> absent. See `cart-and-auth-flow.md`.

Per-endpoint header matrix (corrected — all cart headers **required** unless the
cart does not yet exist):

| Endpoint | X-CART-ID | X-CART-SECRET | Authorization | Notes |
|---|---|---|---|---|
| `POST /api/cart` (create) | — | — | optional | No cart headers; cart doesn't exist yet |
| `GET /api/cart` (read) | **required** | **required** | when logged in | |
| `POST /api/cart/items` (add) | **required** | **required** | when logged in | |
| `PUT /api/cart/items/{item}` (update) | **required** | **required** | when logged in | Secret added (spec omitted it) |
| `DELETE /api/cart/items/{item}` (delete) | **required** | **required** | when logged in | Secret added (spec omitted it) |
| `POST /api/cart/claim` | **required** (single string) | **required** | **required** | Single id, not array |

### POST /api/cart  (create cart)
- Headers: `Accept`, `Content-Type`, `Authorization` (optional for guests). No cart
  headers (the cart does not exist yet).
- 200 body empty in spec. **(derived)** Returns the cart's identifying values —
  persist them for all subsequent cart calls. Verify the actual response keys
  before modelling; do not assume `id`/`secret` naming.

### GET /api/cart  (read cart)
- Headers: `X-CART-ID` (required), `X-CART-SECRET` (required), plus `Authorization`
  when logged in.

### POST /api/cart/items  (add to cart)
- Body: `{ product_id, quantity }` (both required ints).
- Headers: `X-CART-ID` (required), `X-CART-SECRET` (required), `Authorization` when
  logged in.

### PUT /api/cart/items/{item}  (update quantity)
- Path: `item`. Body: `{ quantity }` (int, required).
- Headers: `X-CART-ID` (required), `X-CART-SECRET` (**required — added; the spec
  omitted it**), plus `Accept`/`Content-Type`.

### DELETE /api/cart/items/{item}  (delete item)
- Path: `item`.
- Headers: `X-CART-ID` (required), `X-CART-SECRET` (**required — added; the spec
  omitted it**), plus `Accept`/`Content-Type`.

### POST /api/cart/claim
- Headers: `X-CART-ID` (required, **single string** — not an array), `X-CART-SECRET`
  (required), `Authorization` (required), `Accept`, `Content-Type`.
- Merges the guest cart into the authenticated account. Call once, immediately
  after a successful login/register, when a guest cart exists.

## Payment (`Shamo Apps/Payment`)

### POST /api/payments/midtrans/callback
- This is a Midtrans server-to-server webhook (fields: `transaction_status`,
  `order_id`, `signature_key`, `gross_amount`, etc.). It is **not** called by the
  mobile client. Do not implement a client call for it. If the app needs payment
  status, poll the transaction detail endpoint instead. Flag this to the requester
  if asked to "integrate payment callback" from the app.

## Environment & base URL (Laravel Valet, local + ngrok)

The backend runs locally under Laravel Valet at `http://shamoapps.test`. Valet
routes by the `.test` Host header, which emulators and physical phones cannot
resolve. There are **three access modes**; the integration must support switching
between them by configuration only, never by editing code.

**Golden rule:** who sets the `Host: shamoapps.test` header depends on the mode.
For direct-to-Valet modes the **app** sends it. For ngrok, **ngrok rewrites it**
server-side and the app must NOT send its own Host.

| Mode | `API_BASE_URL` | App sends `Host: shamoapps.test`? | When to use |
|---|---|---|---|
| Emulator → Valet | `http://10.0.2.2` (`:PORT` if not 80) | **Yes** | Android emulator on the same Mac |
| Physical phone → Valet | `http://<Mac-LAN-IP>` (e.g. `http://192.168.1.50`) | **Yes** | Phone on the same Wi-Fi as the Mac |
| Any device → ngrok | `https://<sub>.ngrok-free.dev` | **No** — ngrok rewrites it | Phone off-LAN, external demo, Midtrans webhook |

### Direct-to-Valet modes (emulator / LAN)

- Base URL is an IP, injected via `--dart-define=API_BASE_URL=...`, read with
  `const String.fromEnvironment('API_BASE_URL')`.
- A single interceptor attaches a constant `Host: shamoapps.test`. Without it Valet
  returns its own `404 - Not Found` HTML (not a JSON envelope).
- **Dio caveat:** do not rely on `'Host'` in `BaseOptions.headers` — `dart:io`'s
  HttpClient may drop or overwrite it (dio issue #1577). Set Host in the
  `onRequest` interceptor and build Dio with `preserveHeaderCase: true`, then
  verify via a logging interceptor/proxy that the outgoing request truly carries
  `Host: shamoapps.test`. A persistent `Valet - Not Found` despite "sending" Host
  usually means it was stripped.
- Physical phone caveat: Valet's nginx listens on `127.0.0.1` by default, so a phone
  hitting the Mac's LAN IP can get connection-refused. If the emulator works but the
  phone cannot connect, suspect this before touching app code — it is environment,
  not a bug.

### ngrok mode

- Start the tunnel with Host rewrite so Valet can route:
  `ngrok http --host-header=shamoapps.test 80`
  (use the port Valet serves; 80 for plain, 443 if you run `valet secure`).
- Because ngrok rewrites the Host to `shamoapps.test` server-side, the app must
  **not** attach its own `Host` header in this mode. Sending both is redundant and
  can produce a mismatch. The Host interceptor must therefore be **mode-aware**:
  attach `Host` only in direct-to-Valet modes, skip it for ngrok.
- ngrok free rotates the subdomain on every restart, so `API_BASE_URL` changes each
  session. This is exactly why the URL is a `--dart-define`, not a constant.
- A tunnel-level error returns ngrok's own HTML/text (e.g. "Received a request for a
  different Host…"), not the envelope. Treat any non-JSON body as a transport
  failure; never feed it to the envelope parser.

### Recommended config toggle

Drive the Host behaviour from a single flag alongside the base URL, e.g.
`--dart-define=API_USE_NGROK=true` (default false). When true, the interceptor skips
the `Host` header; when false, it attaches `shamoapps.test`. This keeps a device on
any mode by build flags only, with zero source changes.

> The spec's `dev.*` / `test.*` hosts are placeholders and must never be committed.
> Keep the Valet host name and the ngrok flag in config, not inline.

## Other general notes

- Timestamps are ISO 8601 UTC strings; parse to `DateTime` in the model.
- HTML descriptions are raw HTML; the domain entity carries the string as-is and
  the presentation layer decides how to render it.
- Prices: `price` is an integer; `formatted.price` is a pre-localized display
  string. Carry both if the UI needs the formatted form; do not re-derive one from
  the other.
