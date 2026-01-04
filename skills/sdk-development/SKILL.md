---
name: sdk-development
description: Develop and design SDKs for web APIs (REST/GraphQL/OpenAPI), including API surface design, client architecture, auth, errors, retries, pagination, and release practices. Use this skill when asked to create, refactor, or review an SDK, generate language-specific clients, or produce SDK guidelines, checklists, and docs for API consumption.
---

# SDK Development

## Overview

Design and implement SDKs that feel reliable, idiomatic, and consistent across languages. Focus on API surface design, client architecture, error/retry strategy, pagination helpers, and release readiness.

## Workflow Decision Tree

- If the request is about principles or best practices, read `references/open-source-sdk-essentials.md`.
- If the request is about delivery readiness, read `references/sdk-checklists.md`.
- If the request is about code or concrete SDK work, follow the workflow below.

## Step 1: Clarify Inputs

Ask for the minimum needed to proceed:
- API type and spec availability (OpenAPI/GraphQL/handwritten docs).
- Target languages and runtime versions.
- Auth methods (API key, OAuth, JWT/service account).
- Required features (pagination, streaming, file upload, webhooks).
- Compatibility constraints (backward compatibility, semver policy).

If any are missing, proceed with reasonable defaults and state assumptions.

## Step 2: Define the SDK Surface

Establish the contract before implementation:
- Map API resources to client namespaces and verbs.
- Define request/response models and optional parameters.
- Decide sync vs async clients and streaming patterns.
- Establish error taxonomy and idempotency guidance.

Reference: `references/open-source-sdk-essentials.md`.

## Step 3: Core Client Architecture

Implement the shared HTTP core:
- Config: base URL, auth, timeout, retries, user agent, telemetry.
- Middleware/hooks: auth injection, retries, logging, tracing.
- Error parsing: typed errors with raw response metadata preserved.
- Retry/backoff: exponential + jitter; respect Retry-After.

## Step 4: Add SDK Conveniences

Add ergonomics that reduce user code:
- Pagination helpers (iterators/auto-pagers).
- File upload/download and streaming helpers.
- Long-running operation polling if applicable.

## Step 5: Documentation and Samples

Create:
- Quickstart: install, auth, first request.
- Common workflows with copy-paste samples.
- Behavior docs for errors, retries, pagination, and timeouts.

## Step 6: Test and Release

Ensure:
- Unit tests for serialization, errors, retries, pagination.
- Integration tests when credentials are available.
- Versioning, changelog, and release checklist.

Reference: `references/sdk-checklists.md`.

## Output Expectations

- Provide an SDK plan (surface + architecture) before code.
- Call out assumptions and missing inputs.
- Keep guidance language-idiomatic; do not force cross-language patterns.

## Bundled References

- `references/open-source-sdk-essentials.md` for distilled best practices.
- `references/sdk-checklists.md` for design, implementation, docs, and release.
