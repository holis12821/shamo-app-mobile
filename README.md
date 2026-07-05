# Shamo API Integration — Skill Package

This package contains a Claude Code **skill** plus a **task/command spec** for
integrating the Shamo REST API into an existing Flutter app built with Clean
Architecture and the BLoC pattern.

## Contents

```
shamo-api-integration/
├── SKILL.md                          # The skill (rules + integration flow)
├── INTEGRATION_TASK.md               # Command spec for the agent (what to build)
├── README.md                         # This file
└── references/
    ├── api-contract.md               # Per-endpoint contracts + envelope + errors
    ├── cart-and-auth-flow.md         # Guest-cart headers + token refresh/retry
    └── layer-templates.md            # Per-layer code skeletons
```

## How to install the skill

Copy the whole `shamo-api-integration/` folder into your project's skills
directory:

- Project-scoped (shared with your team via git):
  `.claude/skills/shamo-api-integration/`
- Personal (all your projects):
  `~/.claude/skills/shamo-api-integration/`

Keep the `references/` subfolder intact — `SKILL.md` points to those files and
loads them on demand.

## How to use it

1. Open Claude Code inside your Flutter project.
2. The skill triggers automatically when you ask to integrate a Shamo endpoint
   (its `description` covers auth, user, product, cart, checkout, transaction).
3. To run the full guided integration, hand the agent `INTEGRATION_TASK.md`, e.g.
   "Follow INTEGRATION_TASK.md, start with Phase 1 and stop for review."

## Access modes (Valet local + ngrok)

The backend runs under Laravel Valet at `http://shamoapps.test`, which routes by the
`.test` Host header that devices can't resolve. The skill supports three modes,
switched by build flags only — no source changes:

| Mode | `API_BASE_URL` | App sends `Host`? |
|---|---|---|
| Android emulator → Valet | `http://10.0.2.2` | Yes (`shamoapps.test`) |
| Physical phone → Valet (same Wi-Fi) | `http://<Mac-LAN-IP>` | Yes (`shamoapps.test`) |
| Any device → ngrok | `https://<sub>.ngrok-free.dev` | No — ngrok rewrites it |

Confirmed working with `ngrok http --host-header=shamoapps.test 80`. The Host
interceptor is mode-aware (`--dart-define=API_USE_NGROK=true` skips the app-side
Host). Full details and copy-paste build commands are in
`references/api-contract.md` → "Environment & base URL" and the Dio template in
`references/layer-templates.md`.

## Why the skill is structured this way

The Shamo spec has three sharp edges that cause bugs if integrated naively, all of
which the skill encodes as hard rules:

- **Non-uniform error shapes** — success uses `{ meta, data }`, but the 401 on
  register nests `data.message`/`data.error`, and the 500 returns a bare string.
  One central error mapper handles all three.
- **Guest-cart session headers (confirmed)** — cart/checkout use
  `X-CART-ID`/`X-CART-SECRET` rather than the Bearer token, with the guest cart
  claimed on login. Per backend confirmation (overriding the source spec), both
  headers are **required** on every cart endpoint operating on an existing cart —
  including update and delete, which the spec wrongly omitted the secret from — and
  `X-CART-ID` on claim is a single string, not an array. The skill attaches both
  headers via interceptor and fails fast on a missing required header.
- **Empty example responses (now largely verified)** — several endpoints showed
  `{}` in the spec. Auth (login/register), product list, and refresh have since been
  confirmed against the live API and encoded as fact; the remaining empty ones are
  marked for verification and modelled defensively rather than guessed. Key
  confirmed facts: product list is `data.products` with `pagination` in `meta`;
  `user.roles` is a String; refresh returns `{ access_token, token_type }` only.

## Project conventions this skill targets

The skill is aligned to the repo's `PROJECT_STRUCTURE.md` / `CLAUDE.md`: layer-first
folders, `@JsonSerializable(fieldRename: snake)` models with a `map()` to entities
(models don't extend entities), `flutter_bloc ^7` sealed-style BLoCs (separate
Equatable state classes under an abstract base),
`dartz Either` + `Failure`, `get_it` DI, separate `refreshDio` for token refresh.

## Note on the payment endpoint

`POST /api/payments/midtrans/callback` is a Midtrans server-to-server webhook, not
a mobile client call. The skill and task spec both instruct the agent **not** to
build a client integration for it, and to poll transaction detail for payment
status instead.
