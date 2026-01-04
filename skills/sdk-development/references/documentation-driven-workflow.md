# Documentation-Driven Workflow Templates

This document provides templates for the documentation-first SDK development workflow.

## Template 1: SDK Plan Document

```markdown
# {SDK Name} - {Language} SDK Implementation Plan

## Overview

{Brief description of the SDK purpose and target API}

## Project Structure

{sdk-directory}/
├── package.json / setup.py / Cargo.toml
├── tsconfig.json / pyproject.toml / etc.
├── build-config (tsup/rollup/webpack/etc.)
├── test-config (vitest/jest/pytest/etc.)
├── README.md
├── src/
│   ├── index.{ext}                    # Main entry point
│   ├── client.{ext}                   # Client class
│   ├── version.{ext}                  # SDK version
│   ├── core/
│   │   ├── http.{ext}                 # HTTP client
│   │   ├── retry.{ext}                # Retry logic
│   │   ├── errors.{ext}               # Error types
│   │   ├── types.{ext}                # Core types
│   │   └── polling.{ext}              # Polling helpers
│   ├── resources/
│   │   ├── resource1.{ext}
│   │   └── resource2.{ext}
│   └── types/
│       ├── resource1.{ext}
│       └── resource2.{ext}
├── tests/
│   ├── unit/
│   └── integration/
├── examples/
└── docs/
    ├── {sdk-name}-plan.md             # This file
    ├── {sdk-name}-todo.md             # TODO tracker
    └── architecture/
        ├── {sdk-name}-architecture-step1-{name}.md
        └── {sdk-name}-architecture-step2-{name}.md

## Implementation Steps

### Step 1: Project Initialization

{Description of what this step accomplishes}

- Create {sdk-directory}/ directory
- Configure package manager ({package-file})
- Configure language/compiler ({config-file})
- Configure build tool ({build-config})
- Configure test framework ({test-config})

### Step 2: Core Modules

{Description of core infrastructure}

- src/core/types.{ext} - ClientOptions, RequestOptions, PollingOptions
- src/core/errors.{ext} - Error type hierarchy:
  - {BaseError} (base class)
  - {AuthenticationError} (401)
  - {RateLimitError} (429)
  - {NotFoundError} (404)
  - {ValidationError} (400/422)
  - {NetworkError}, {TimeoutError}
  - {TaskTimeoutError}, {TaskFailedError}
- src/core/retry.{ext} - Exponential backoff + jitter algorithm
- src/core/polling.{ext} - Task polling helper (pollUntilComplete)
- src/core/http.{ext} - HTTP client:
  - Auth header injection
  - Automatic retry (network errors, 5xx, 429)
  - Timeout handling
  - Error parsing

### Step 3: Type Definitions

{Description of API type system}

- src/types/resource1.{ext} - Resource 1 types
- src/types/resource2.{ext} - Resource 2 types
- {List all resource type files}

### Step 4: Resource Implementation

{Description of API resource mapping}

- src/resources/resource1.{ext} - Resource 1 methods:
  - method1 / getMethod1
  - method2 / getMethod2
- src/resources/resource2.{ext} - Resource 2 methods:
  - method1 / getMethod1
  - method2 / getMethod2
- {List all resource files and their methods}

### Step 5: Main Client

{Description of client entry point}

- Implement {ClientClass} entry point
- Mount all resources as properties
- Export public API (index.{ext})
- Set SDK version

### Step 6: Testing

{Description of test coverage}

- Unit tests for errors/retry/polling/http
- Unit tests for each resource
- Integration tests (optional, requires API credentials)

### Step 7: Documentation and Examples

{Description of user-facing docs}

- README: installation, API key setup, quickstart, error handling
- Examples: {list common use cases}
- CHANGELOG

## Configuration Details

### Language/Runtime

- Language: {language} ({version})
- Build: {build-tool} outputs {formats}
- Test: {test-framework}

### Dependencies

{List key dependencies and their purposes}

### API Specifications

- Base URL: {base-url}
- Auth method: {auth-method}
- Error response format: {error-format}
- Task status values: {status-values}
```

## Template 2: TODO Tracker Document

```markdown
# {SDK Name} TODO

## Preparation

- [ ] Confirm API base URL and version
- [ ] Confirm error response format and requestId field
- [ ] Confirm task status return structure for all resources
- [ ] {Add other verification tasks}

## Step 1: Project Initialization

- [ ] Create {sdk-directory}/ directory
- [ ] Configure {package-file} (name: {package-name}, {runtime}>=version)
- [ ] Configure {config-file} ({target}, strict)
- [ ] Configure {build-config} ({output formats})
- [ ] Configure {test-config}

## Step 2: Core Modules

- [ ] Define ClientOptions/RequestOptions/PollingOptions
- [ ] Implement error type hierarchy and error parsing
- [ ] Implement retry with exponential backoff + jitter
- [ ] Implement task polling helper
- [ ] Implement HTTP client (auth/timeout/retry)

## Step 3: Type Definitions

- [ ] resource1 types ({list key types})
- [ ] resource2 types ({list key types})
- [ ] {Add all resource type tasks}

## Step 4: Resource Implementation

- [ ] resource1: method1/getMethod1/method2/getMethod2
- [ ] resource2: method1/getMethod1/method2/getMethod2
- [ ] {Add all resource implementation tasks}

## Step 5: Main Client

- [ ] Implement {ClientClass} entry point and resource mounting
- [ ] Export public API (index.{ext})
- [ ] Set SDK version

## Step 6: Testing

- [ ] errors/retry/polling/http unit tests
- [ ] resource unit tests
- [ ] integration tests (optional)

## Step 7: Documentation and Examples

- [ ] README: installation, API key config, quickstart, error handling
- [ ] Example: {use case 1}
- [ ] Example: {use case 2}
- [ ] CHANGELOG
```

## Template 3: Step Architecture Document

```markdown
# {SDK Name} Architecture - Step {N}: {Step Name}

This document describes the {Step Name} architecture and implementation requirements.

## Scope

{What this step covers, what files are created/modified}

## File Structure

- {file-path-1} - {purpose}
- {file-path-2} - {purpose}
- {file-path-3} - {purpose}

## Key Type Definitions

### {TypeName1}

```{language}
{type definition}
```

**Purpose**: {description}

**Fields**:
- `field1` - {description}
- `field2` - {description}

### {TypeName2}

```{language}
{type definition}
```

**Purpose**: {description}

## Implementation Rules

### {Rule Category 1}

- {Rule 1}
- {Rule 2}
- {Rule 3}

### {Rule Category 2}

- {Rule 1}
- {Rule 2}

## Error Handling

{Describe error handling strategy for this step}

Error parsing priority:
1. {field1}
2. {field2}
3. {fallback}

Error mapping:
- {status code 1} → {ErrorType1}
- {status code 2} → {ErrorType2}

## Retry Strategy

{Describe retry behavior for this step}

- Retry conditions: {list conditions}
- Backoff algorithm: {describe algorithm}
- Max retries: {default value}
- Idempotency: {which methods are idempotent}

## Testing Requirements

### Unit Tests

- [ ] {test scenario 1}
- [ ] {test scenario 2}
- [ ] {test scenario 3}

### Integration Tests (Optional)

- [ ] {integration scenario 1}
- [ ] {integration scenario 2}

## Integration Notes

{How this step integrates with previous steps}

Dependencies:
- Requires: {list required previous steps}
- Provides: {list what this exposes for future steps}

## Example Usage

```{language}
{code example showing how components from this step are used}
```
```

## Template 4: Commit Message Structure

```
{Concise summary of what was added/implemented}

- Write architecture/{sdk-name}-architecture-step{N}-{name}.md
- Implement src/{module1}.{ext} with {description}
- Implement src/{module2}.{ext} with {description}
- Add {unit/integration} tests for {what was tested}
- Update {sdk-name}-todo.md: mark Step {N} tasks complete
```

Examples:

```
Initialize @runapi/sdk JavaScript SDK project

- Set up sdk/js directory structure with TypeScript configuration
- Configure tsup for CJS + ESM dual format output
- Configure vitest for unit and integration testing
- Add project documentation and implementation plan
```

```
Implement JS SDK core modules and error handling

- Write architecture/sdk-js-architecture-step2-core.md
- Implement src/core/errors.ts with full error taxonomy
- Implement src/core/http.ts with retry and auth
- Implement src/core/polling.ts for async task handling
- Add unit tests for error parsing and retry logic
- Update sdk-js-todo.md: mark Step 2 core tasks complete
```

```
Add JS SDK architecture docs for steps 1-2

- Document project initialization in architecture/sdk-js-architecture-step1-init.md
- Document core modules in architecture/sdk-js-architecture-step2-core.md
- Include type definitions, error handling, and retry strategies
```

## Workflow Best Practices

### Documentation First

1. Never write code before writing the architecture doc for that step
2. Architecture docs should be complete enough that implementation is mechanical
3. Update docs when you discover issues during implementation

### TODO Discipline

1. Update TODO status before starting a step (mark as in-progress)
2. Check off sub-tasks as you complete them
3. Add emoji markers when entire steps are done
4. Document deviations or new discoveries in TODO

### Commit Hygiene

1. Each commit should represent one complete step or logical unit
2. Commit message must reference:
   - Architecture docs written/updated
   - Implementation files created
   - Tests added
   - TODO progress
3. Never commit code without updating corresponding TODO items

### Incremental Development

1. Implement steps in order - don't skip ahead
2. Verify each step works before moving to the next
3. Write tests alongside implementation, not after
4. Run tests before committing

### Documentation Quality

1. Architecture docs should include:
   - Clear scope statement
   - Complete type definitions
   - Implementation constraints
   - Testing requirements
   - Integration notes
2. TODO items should be:
   - Concrete and verifiable
   - Organized hierarchically
   - Updated progressively
   - Marked with status and emoji

### Integration

1. Document how each step integrates with previous work
2. Identify dependencies explicitly
3. Note breaking changes or API surface changes
4. Update main plan if scope changes
