# SDK Checklists

## Design Checklist
- Identify primary resources and verbs; map to client methods.
- Define config: base URL, auth, timeout, retries, user agent, telemetry.
- Specify error taxonomy and payloads.
- Decide pagination model and helper shape.
- Decide async model (sync/async clients, streaming).
- Plan idempotency and retry rules.

## Implementation Checklist
- HTTP layer with middleware/hooks for auth, retries, logging, telemetry.
- Request/response models with validation and serialization.
- Error parsing with typed subclasses and raw data preservation.
- Pagination helpers; iterable/pager tests.
- File upload/download and streaming if needed.
- Rate limiting behavior and Retry-After handling.

## Docs Checklist
- Quickstart with install, auth, and first request.
- Common workflows with code samples.
- Errors, retries, pagination, and timeouts explained.
- API reference generation plan (OpenAPI/Smithy/etc.).

## Release Checklist
- Versioning policy (semver) and deprecation notes.
- Changelog update and migration guidance for breaking changes.
- CI green: lint, type, unit, integration (if available).
- Package metadata, license, and repository links updated.
