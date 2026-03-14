# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

elogir is a monorepo for an offline-first Flutter app ecosystem. It uses Melos 7.x with Dart pub workspaces for package management. Currently contains one shared package (`elogir_ui`) and one app (`elogir_notes`). Future packages include `elogir_core` (local DB, sync, auth) and `elogir_auto` (automation engine), with up to 25 apps planned.

All apps use the `elogir_ui` design system ("Soft Industrial" — thick borders, warm neutrals, no Material/Cupertino). Apps set `uses-material-design: false` and import only `package:flutter/widgets.dart`.

## Commands

```bash
# Bootstrap workspace (install deps, link local packages)
melos bootstrap

# Static analysis across all packages
melos run analyze

# Run tests across all packages
melos run test

# Check formatting
melos run format

# Run a single app's tests
cd apps/elogir_notes && flutter test

# Run a single test file
cd apps/elogir_notes && flutter test test/widget_test.dart

# Run an app
cd apps/elogir_notes && flutter run
```

## Monorepo Structure

- **Root `pubspec.yaml`**: Workspace definition with `workspace:` globs (`packages/**`, `apps/**`) and inline `melos:` config. Not a publishable package.
- **`packages/`**: Shared libraries. Every package pubspec must have `resolution: workspace`.
- **`apps/`**: Flutter applications. Each depends on shared packages via bare dependency (e.g., `elogir_ui:` with no path — the workspace resolves it).

## Adding a New Package or App

1. Create the directory under `packages/` or `apps/`
2. Add `resolution: workspace` to its `pubspec.yaml`
3. Run `melos bootstrap` — the `packages/**`/`apps/**` globs auto-discover it
4. Platform symlink directories (`.symlinks/`, `.plugin_symlinks/`) inside example/platform folders can conflict with workspace globs — delete them before bootstrapping if you hit `resolution: workspace` errors on transitive plugins.

## Tech Stack

**Language**: Dart end-to-end (Flutter for frontend, Serverpod for backend).

**State management**: Riverpod with `riverpod_generator`. Only generator-based providers — no manual provider declarations.

**Data classes**: Freezed with `freezed_annotation`. All models are immutable Freezed classes with unions, `copyWith`, and JSON serialization.

**Routing**: `go_router` with `go_router_builder`. Type-safe, declarative routes via code generation.

**Local database**: Drift (SQLite). Type-safe queries with code generation, schema migrations, full platform support including web via sql.js. All database access goes through `elogir_core`.

**HTTP**: `dio` with interceptors, retry logic, and request cancellation.

**Logging**: `talker` with `talker_riverpod_logger` and `talker_dio_logger` for structured logging hooked into Riverpod lifecycle and Dio request/response cycle.

**Backend**: Serverpod (currently offline-focused; server is for future sync).

**Code generation**: Heavily code-gen driven. Riverpod providers, Freezed classes, Drift databases, and go_router routes all use `build_runner`. Regenerate with `dart run build_runner build --delete-conflicting-outputs`. Generated files (`.g.dart`, `.freezed.dart`) must never be edited by hand.

### Core Libraries

- `riverpod`, `riverpod_generator` — state management
- `freezed`, `freezed_annotation` — immutable data classes
- `go_router`, `go_router_builder` — routing
- `drift`, `drift_dev` — local database
- `dio` — HTTP client
- `connectivity_plus` — network state detection for offline-first logic
- `flutter_secure_storage` — encrypted storage for secrets and tokens
- `path_provider` — cross-platform file paths
- `flutter_local_notifications` — local notifications
- `intl` — internationalization and localization
- `rxdart` — reactive streams, especially in `elogir_auto`'s event engine
- `talker`, `talker_riverpod_logger`, `talker_dio_logger` — logging
- `envied` — type-safe environment variables
- `fl_chart` — charts and graphs (Finance, Health, Habits, and data visualization apps)

### Dev & Quality Libraries

- `very_good_analysis` — strict lint rules enforced across all apps
- `mocktail` — mocking for unit tests
- `melos` — monorepo management
- `build_runner` — code generation runner for Drift, Freezed, Riverpod, and go_router
- `custom_lint` — project-specific lint rules beyond `very_good_analysis`

## Architecture

See `packages/elogir_ui/CLAUDE.md` for elogir_ui-specific guidance (theme system, widget patterns, key constraints).

### App Pattern

Apps follow the `elogir_ui/example/` pattern:
- Wrap in `ElogirApp` (or `ElogirApp.router` for go_router) with `ElogirThemeData.light()` / `.dark()`
- Use `ThemeMode` enum from `elogir_ui` (not Material's) for light/dark switching
- Access theme tokens via `ElogirTheme.of(context)` for spacing, colors, typography
