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

### App Directory Structure

All apps target desktop, tablet, and mobile. Every app follows this layout:

```
apps/elogir_<name>/
├── lib/
│   ├── main.dart                        # Entry point — calls bootstrap(), runApp()
│   ├── app/
│   │   ├── app.dart                     # ElogirApp.router wired to GoRouter + theme
│   │   └── bootstrap.dart               # Async init: Drift DB, Talker, secure storage
│   ├── config/
│   │   ├── env.dart                     # Envied-generated environment variables
│   │   └── constants.dart               # App-wide constants
│   ├── routing/
│   │   ├── router.dart                  # GoRouter instance as riverpod_generator provider
│   │   └── routes.dart                  # TypedGoRoute declarations → routes.g.dart
│   ├── layout/
│   │   ├── breakpoints.dart             # compact (<600) / medium (600–839) / expanded (≥840)
│   │   ├── responsive_builder.dart      # Widget that selects child per breakpoint
│   │   └── app_shell.dart               # Adaptive shell: bottom nav / rail / sidebar
│   ├── features/
│   │   └── <feature>/
│   │       ├── models/                  # Freezed domain models → .freezed.dart, .g.dart
│   │       ├── providers/               # riverpod_generator providers → .g.dart
│   │       ├── repositories/            # Concrete repository class talking to Drift DAO
│   │       ├── screens/                 # Route-target pages (full-screen widgets)
│   │       └── widgets/                 # Feature-scoped UI components
│   ├── shared/
│   │   ├── models/                      # Cross-feature Freezed models
│   │   ├── providers/                   # App-wide providers (DB, connectivity, Talker)
│   │   ├── widgets/                     # App-specific reusable widgets (beyond elogir_ui)
│   │   └── extensions/                  # Dart extension methods
│   └── database/
│       ├── app_database.dart            # Drift @DriftDatabase class → .g.dart
│       ├── daos/                        # Drift DAOs, one per feature's tables
│       └── tables/                      # Drift table definitions
├── test/
│   ├── helpers/
│   │   ├── pump_app.dart                # Test wrapper: ProviderScope + ElogirApp + theme
│   │   ├── mocks.dart                   # Mocktail mock classes
│   │   └── fakes.dart                   # Fake implementations for repositories
│   ├── fixtures/
│   │   └── <name>_fixtures.dart         # Factory functions producing test data
│   ├── features/
│   │   └── <feature>/
│   │       ├── models/                  # Serialization, copyWith, equality tests
│   │       ├── providers/               # ProviderContainer tests with overrides
│   │       ├── repositories/            # Integration tests against Drift in-memory DB
│   │       └── screens/                 # Widget tests using pumpApp helper
│   └── routing/
│       └── router_test.dart             # Route resolution and redirect tests
├── pubspec.yaml
├── analysis_options.yaml
└── build.yaml                           # build_runner config (Drift, Freezed, Riverpod, go_router)
```

### Data Flow

```
┌───────────┐      ┌──────────────┐      ┌───────────┐
│    UI     │─────▶│  Repository  │─────▶│   Drift   │
│ + Providers      │  (read/write)│      │ (SQLite)  │
└───────────┘      └──────────────┘      └─────┬─────┘
                                               │ streams / change tracking
                                         ┌─────▼─────┐
                                         │ SyncEngine│ (elogir_core, future)
                                         │(Serverpod)│
                                         └───────────┘
```

Drift is always the local source of truth. Repositories read/write Drift only. When Serverpod is added, a sync engine in `elogir_core` will watch Drift for local changes and reconcile with the server in the background. Apps never talk to Serverpod directly — they just read/write Drift as always.

### Model Layers

Three model types exist, but the Freezed domain model is the lingua franca used in UI and providers:

| Layer | Type | Location | Used by |
|-------|------|----------|---------|
| **Domain** | Freezed classes | `features/*/models/` | UI, providers, repository public API |
| **Persistence** | Drift table companions | `database/tables/` | Repositories only (mapping to/from domain) |
| **API** (future) | Serverpod models | `elogir_core` | Sync engine only (mapping to/from domain) |

UI and providers never import Drift companions or Serverpod models directly. Repositories handle all mapping.

### Provider Architecture

All providers use `riverpod_generator` — no manual `Provider(...)` declarations. Providers form a dependency chain where each layer is independently testable:

**DB → Repository → Data providers → UI**

```dart
// shared/providers/database_provider.dart
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => throw UnimplementedError();
// ↑ overridden in ProviderScope at bootstrap

// features/notes/providers/note_repository_provider.dart
@riverpod
NoteRepository noteRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return NoteRepository(db.noteDao);
}

// features/notes/providers/notes_provider.dart
@riverpod
Stream<List<Note>> notes(Ref ref) {
  return ref.watch(noteRepositoryProvider).watchAll();
}
```

### Repository Pattern

Repositories are concrete classes (not abstract interfaces). Each repository talks to one Drift DAO and maps between Drift row objects and Freezed domain models:

```dart
class NoteRepository {
  const NoteRepository(this._dao);
  final NoteDao _dao;

  Stream<List<Note>> watchAll() =>
      _dao.watchAllNotes().map((rows) => rows.map(_toModel).toList());

  Future<void> save(Note note) => _dao.upsertNote(_toRow(note));
  Future<void> delete(String id) => _dao.deleteNote(id);
}
```

No abstract interfaces, no multiple implementations. When Serverpod arrives, sync happens below Drift (via a sync engine watching changes), not by swapping repositories.

### Responsive Layout

Apps support three form factors via breakpoints:

| Size | Width | Navigation | Use case |
|------|-------|------------|----------|
| **compact** | < 600dp | `ElogirBottomNav` | Phone |
| **medium** | 600–839dp | Navigation rail | Tablet portrait, foldables |
| **expanded** | ≥ 840dp | Persistent sidebar | Tablet landscape, desktop |

go_router's `ShellRoute` wraps routes in an `AppShell` that switches navigation chrome per breakpoint. Screens are form-factor-agnostic — only the shell adapts.

### Routing

Type-safe routes via `go_router_builder`. Routes are declared as `TypedGoRoute` classes that generate `$xxxRoute` extensions. The `AppShell` is a `ShellRoute` wrapping all top-level destinations:

```dart
@TypedShellRoute<AppShellRoute>(
  routes: [
    TypedGoRoute<NotesRoute>(path: '/notes', routes: [
      TypedGoRoute<NoteDetailRoute>(path: ':id'),
    ]),
    TypedGoRoute<SettingsRoute>(path: '/settings'),
  ],
)
class AppShellRoute extends ShellRouteData {
  @override
  Widget builder(context, state, navigator) => AppShell(navigator: navigator);
}
```

### Bootstrap

`main.dart` calls `bootstrap()` which initializes async dependencies, then runs the app inside a `ProviderScope` with overrides for initialized instances:

```dart
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = Talker();
  final db = AppDatabase();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        talkerProvider.overrideWithValue(talker),
      ],
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: const App(),
    ),
  );
}
```

### App Entry Point

`App` uses `ElogirApp.router` with the GoRouter instance from Riverpod:

```dart
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ElogirApp.router(
      lightTheme: ElogirThemeData.light(),
      darkTheme: ElogirThemeData.dark(),
      routerConfig: router,
    );
  }
}
```

### Testing Strategy

| Layer | Test type | Technique |
|-------|-----------|-----------|
| **Freezed models** | Unit | Serialization round-trip, `copyWith`, equality |
| **Repositories** | Integration | Real Drift in-memory DB (not mocks) |
| **Providers** | Unit | `ProviderContainer` with repository overrides |
| **Screens / widgets** | Widget | `pumpApp` helper providing `ProviderScope` + `ElogirApp` + theme |
| **Routing** | Unit | Route resolution, redirects, parameter parsing |

The `pumpApp` test helper wraps a widget in the full app shell so tests get theme and providers:

```dart
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: ElogirApp(
          lightTheme: ElogirThemeData.light(),
          darkTheme: ElogirThemeData.dark(),
          home: widget,
        ),
      ),
    );
  }
}
```

### App Dependencies

Every app `pubspec.yaml` should include:

```yaml
dependencies:
  flutter:
    sdk: flutter
  elogir_ui:
  # elogir_core:                        # Future: DB helpers, sync engine, auth
  flutter_riverpod:
  riverpod_annotation:
  freezed_annotation:
  json_annotation:
  go_router:
  drift:
  drift_flutter:
  sqlite3_flutter_libs:
  path_provider:
  path:
  connectivity_plus:
  flutter_secure_storage:
  dio:
  talker:
  talker_riverpod_logger:
  talker_dio_logger:
  envied:
  intl:

dev_dependencies:
  flutter_test:
    sdk: flutter
  very_good_analysis:
  build_runner:
  riverpod_generator:
  freezed:
  json_serializable:
  drift_dev:
  go_router_builder:
  envied_generator:
  mocktail:
  custom_lint:
```
