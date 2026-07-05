# Cart Session & Auth Flow Reference

This file covers the two cross-cutting mechanisms that are easy to get wrong:
the guest-cart session headers and the token refresh-and-retry loop. Load it when
integrating any cart/checkout endpoint or when touching the auth interceptor.

## Guest cart session mechanism

> **Status: confirmed by the backend team.** The source spec was wrong on three
> points, now resolved: (1) cart headers are **required**, not optional;
> (2) `PUT`/`DELETE` **do require `X-CART-SECRET`** — all mutations carry both
> headers; (3) `X-CART-ID` on claim is a **single string**, not an array. Because
> the requirement is confirmed, the interceptor **may fail fast** with
> `CartSessionFailure` when a required header is missing.

The cart works for guests and survives login, identified by headers rather than the
Bearer token:

- `X-CART-ID` — the cart identifier (single string everywhere, including claim).
- `X-CART-SECRET` — the secret proving ownership; required on every cart endpoint
  that operates on an existing cart (read, add, update, delete, claim).

### Rules

1. **Create-and-persist.** When no cart is stored and the user performs a cart
   action, call `POST /api/cart`, then persist the returned identifying values
   (verify the actual response keys — do not assume `id`/`secret` naming) in local
   secure storage, separate from the auth token.
2. **Attach on every cart/checkout call, and fail fast when missing.** A dedicated
   interceptor attaches `X-CART-ID` and `X-CART-SECRET` to all cart and checkout
   requests against an existing cart. Because both are required, if either is
   missing when the endpoint needs it, raise `CartSessionFailure` rather than
   sending an incomplete request — the backend would reject it anyway, so fail
   early with a clear cause. The sole exception is `POST /api/cart` (create), which
   runs before any cart exists and carries no cart headers.
3. **Both headers on all mutations.** Send `X-CART-ID` **and** `X-CART-SECRET` on
   read, add, update, delete, and claim. Do not drop the secret on update/delete.
4. **Claim on login.** Immediately after a successful login or register, if a guest
   cart exists in storage, call `POST /api/cart/claim` with both cart headers
   (single-string `X-CART-ID`) and the new `Authorization` token. This merges the
   guest cart into the account.
5. **Lifecycle.** After logout, decide explicitly whether to keep or clear the
   guest cart values. Default: clear the auth token; keep cart values only if the
   app supports post-logout guest browsing, otherwise clear both. Make it explicit.

### Recommended sequencing

```
guest browses ──► add to cart ──► POST /api/cart (if none) ──► store id+secret
                                        │
                                        ▼
                          cart calls carry X-CART-ID/SECRET
                                        │
       user logs in ──► POST /api/auth/login ──► store tokens
                                        │
                                        ▼
             if guest cart exists ──► POST /api/cart/claim (headers + token)
```

## Token attach, refresh, and retry

A single interceptor owns all token logic. Do not read or attach tokens inside data
sources.

### Attach

- On every authenticated request, attach `Authorization: Bearer <access_token>`
  from secure storage. Requests to `register`, `login`, and `refresh` do not carry
  the access token (refresh carries the refresh token per backend convention).

### Refresh-and-retry algorithm

On receiving a 401 that indicates an expired access token:

1. Guard against concurrent refreshes with a single-flight lock (one refresh in
   progress at a time; queue other 401'd requests behind it).
2. Call `POST /api/refresh` with the stored refresh token.
3. On success: the response is `{ access_token, token_type }` only (confirmed —
   `meta.message: "Token refreshed"`). Store the new `access_token`. There is **no
   `refresh_token` in the response — it is not rotated**, so keep the stored refresh
   token as-is. Then retry each queued request **once** with the new access token.
4. On failure (refresh rejected/expired): clear the session (tokens; cart per the
   lifecycle rule), release the lock, and surface `AuthFailure` so the app can route
   to the login screen.
5. Never loop: a request is retried at most once after a refresh. A second 401 on
   the retried request becomes `AuthFailure`, not another refresh attempt.

### Pseudocode

```
onError(response):
  if response.status != 401: rethrow as mapped Failure
  if request was /api/refresh: clearSession(); throw AuthFailure
  acquire refreshLock (single-flight):
    if not alreadyRefreshedThisCycle:
      result = POST /api/refresh (refreshToken)
      if result.ok: saveTokens(result); mark refreshed
      else: clearSession(); throw AuthFailure
  retry original request once with new access token
  if retry still 401: throw AuthFailure
```

### Why single-flight matters

Without the lock, several parallel requests hitting 401 at once each fire their own
refresh, invalidating each other's tokens (if the backend rotates refresh tokens)
and causing a logout storm. The lock makes exactly one refresh happen and shares
its result.
