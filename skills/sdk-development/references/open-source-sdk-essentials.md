# Open-Source SDK Essentials (Distilled)

These principles are distilled from widely used SDKs (e.g., Stripe, AWS, Google, Twilio, Slack, GitHub, Okta, Shopify) and focus on repeatable patterns that make SDKs feel trustworthy and ergonomic.

## API Surface Principles
- Consistent naming: resource + verb (create/list/get/update/delete) with predictable options objects.
- Stable defaults: sensible timeouts, retries, pagination, and backoff without user configuration.
- Minimal magic: avoid surprising global state; keep configuration explicit and composable.
- Forward compatibility: accept and pass through unknown fields where safe.
- Small, focused modules: avoid mega-clients; group by service/resource.

## Errors and Reliability
- Typed errors: base error + subclasses for auth, rate limit, validation, network, and server.
- Preserve request metadata: status, request id, headers, body, raw response.
- Retry strategy: idempotent methods retry by default; non-idempotent retries only with idempotency keys.
- Backoff: exponential with jitter; respect server Retry-After when present.

## Pagination and Long-Running Operations
- Pagination helpers: iterators/auto-pagers with explicit page size and cursor control.
- LROs: expose poll/wait helpers; allow custom polling intervals and deadlines.

## Auth and Security
- Multiple auth strategies: API keys, OAuth, JWT/service accounts as applicable.
- Configurable auth injection: per-client or per-request overrides.
- Sensitive data handling: avoid logging secrets; provide redaction hooks.

## SDK UX
- Clear entry point: a single client constructor with config.
- Predictable request options: timeout, retries, headers, idempotency key, request id.
- Idiomatic language design: follow language norms (naming, async, errors, iterables).
- Rich examples: quickstart + common flows; copy-paste ready.

## Docs and Samples
- Generated reference docs from OpenAPI/Smithy/Discovery where possible.
- Hand-written guides for workflows, pagination, retries, errors, and auth.
- Changelog discipline: human-readable, link to API versions.

## Release Engineering
- Semantic versioning; avoid breaking changes in minors.
- Cross-language alignment: consistent naming + behavior across SDKs.
- CI: lint, type check, unit tests, integration tests (if credentials available).

