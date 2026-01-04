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
- If the request is about code or concrete SDK work, follow the documentation-driven workflow below.

## Documentation-Driven Development Workflow

All SDK work follows a docs-first, incremental approach. Documentation is written before code, and each step produces both architecture docs and working code.

### Phase 0: Project Bootstrap

Before writing any code:

1. **Create the documentation structure** in `docs/` or `sdk/{lang}/docs/`:
   - `{sdk-name}-plan.md` - comprehensive implementation roadmap
   - `{sdk-name}-todo.md` - step-by-step checklist with status markers
   - `architecture/` directory for step-specific architecture docs

2. **Write the SDK Plan** (`{sdk-name}-plan.md`):
   - Overview and project goals
   - Complete directory structure with file purposes
   - Step-by-step breakdown (6-10 major steps)
   - Each step lists specific files to create and their responsibilities
   - Dependencies and integration points
   - Testing strategy and examples structure

3. **Create the TODO tracker** (`{sdk-name}-todo.md`):
   - Hierarchical checklist organized by steps
   - Use `[ ]` for pending, `[x]` for completed
   - Include preparation tasks (confirm API specs, error formats, etc.)
   - Each step broken into concrete, verifiable sub-tasks
   - Add emoji markers for completed steps (e.g., "Step 1: Project Init ✅")

4. **Clarify inputs and constraints**:
   - API type and spec availability (OpenAPI/GraphQL/handwritten docs)
   - Target languages and runtime versions
   - Auth methods (API key, OAuth, JWT/service account)
   - Required features (pagination, streaming, file upload, webhooks)
   - Compatibility constraints (backward compatibility, semver policy)
   - If any are missing, proceed with reasonable defaults and state assumptions

### Phase 1: Step-by-Step Implementation

For each implementation step:

1. **Write step architecture doc** (`architecture/{sdk-name}-architecture-step{N}-{name}.md`):
   - Step title and scope
   - Detailed specifications for this step's components
   - Key type definitions and interfaces
   - Implementation constraints and conventions
   - Testing coverage for this step
   - Integration points with previous steps

2. **Update TODO status**:
   - Mark current step tasks as in-progress
   - Reference the architecture doc in commit or notes

3. **Implement the step**:
   - Follow the architecture doc specifications exactly
   - Create files listed in the plan
   - Write unit tests alongside implementation
   - Verify each sub-task in the TODO

4. **Update TODO completion**:
   - Mark completed sub-tasks with `[x]`
   - Add step completion emoji when all tasks done
   - Document any deviations or discoveries

5. **Commit with structured message**:
   - First line: concise summary of what was added/implemented
   - Blank line
   - Bullet points describing:
     - Architecture docs created/updated
     - Implementation modules added
     - Tests written
     - TODO progress
   - Reference the step number and name

Example commit structure:
```
Add JS SDK core modules and error handling

- Write architecture/sdk-js-architecture-step2-core.md
- Implement src/core/errors.ts with full error taxonomy
- Implement src/core/http.ts with retry and auth
- Implement src/core/polling.ts for async task handling
- Add unit tests for error parsing and retry logic
- Update sdk-js-todo.md: mark Step 2 tasks complete
```

### Phase 2: Integration and Polish

After core steps are complete:

1. **Write integration examples** before implementing convenience features
2. **Document edge cases** and behavior expectations
3. **Update TODO** with discovered items (bugs, improvements, docs gaps)
4. **Iterate** using the same doc-first approach

### Documentation Standards

All architecture docs must include:

1. **Scope statement** - what this step covers
2. **File structure** - which files are created/modified
3. **Type definitions** - core interfaces and types
4. **Implementation rules** - conventions, patterns, constraints
5. **Testing requirements** - what must be tested
6. **Integration notes** - how this connects to other steps

TODO format requirements:

1. **Hierarchical structure** - group by steps and sub-steps
2. **Status markers** - `[ ]` pending, `[x]` done, emoji for step completion
3. **Preparation section** - pre-implementation verification tasks
4. **Granular tasks** - each task is concrete and verifiable
5. **Progressive updates** - TODO is updated with each commit

Reference: See `references/documentation-driven-workflow.md` for templates.

## Step-by-Step Implementation Guide

### Step 1: Project Initialization

Write architecture doc first, then:
- Create directory structure and config files
- Set up build tooling (tsup/rollup/etc.)
- Configure testing framework
- Set up linting and formatting
- Verify build and test runners work

### Step 2: Core Client Architecture

Document the HTTP core, then implement:
- Config: base URL, auth, timeout, retries, user agent, telemetry
- Middleware/hooks: auth injection, retries, logging, tracing
- Error parsing: typed errors with raw response metadata preserved
- Retry/backoff: exponential + jitter; respect Retry-After

Reference: `references/open-source-sdk-essentials.md`.

### Step 3: Type System

Define the complete type surface:
- Request/response models for all resources
- Optional parameters and default values
- Sync vs async clients and streaming patterns
- Error taxonomy and idempotency guidance

### Step 4: Resource Implementation

Implement API resources incrementally:
- Map API endpoints to client methods
- Apply auth and retry from core
- Handle resource-specific errors
- Add unit tests per resource

### Step 5: SDK Conveniences

Add ergonomics that reduce user code:
- Pagination helpers (iterators/auto-pagers)
- File upload/download and streaming helpers
- Long-running operation polling if applicable

### Step 6: Documentation and Samples

Create user-facing docs:
- Quickstart: install, auth, first request
- Common workflows with copy-paste samples
- Behavior docs for errors, retries, pagination, and timeouts

### Step 7: Test and Release

Ensure quality and readiness:
- Unit tests for serialization, errors, retries, pagination
- Integration tests when credentials are available
- Versioning, changelog, and release checklist

Reference: `references/sdk-checklists.md`.

## Output Expectations

- Always create plan + TODO docs before any code
- Write step architecture docs before implementing each step
- Update TODO status with every commit
- Commit messages must reference docs and TODO progress
- Call out assumptions and missing inputs
- Keep guidance language-idiomatic; do not force cross-language patterns

## Bundled References

- `references/open-source-sdk-essentials.md` for distilled best practices.
- `references/sdk-checklists.md` for design, implementation, docs, and release.
