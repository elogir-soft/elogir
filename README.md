# elogir

A monorepo for an offline-first Flutter app ecosystem. Built with Dart end-to-end, using a shared design system and common architecture across all apps.

## Apps

| App | Description |
|-----|-------------|
| [elogir_alarm](apps/elogir_alarm) | Alarms, timers, and stopwatch with native alarm scheduling |
| [elogir_calc](apps/elogir_calc) | Calculator with basic and scientific modes, calculation history |
| [elogir_home](apps/elogir_home) | Smart home device control and automation via Tuya |
| [elogir_notes](apps/elogir_notes) | Minimal note-taking app (proof of concept) |

## Packages

| Package | Description |
|---------|-------------|
| [elogir_ui](packages/elogir_ui) | "Soft Industrial" design system -- zero Material/Cupertino, built from Flutter primitives |
| [elogir_auto](packages/elogir_auto) | Smart device control library for IoT integration (Tuya, extensible to Matter/HomeKit) |
| [elogir_updater](packages/elogir_updater) | Auto-update service via GitHub Releases for Android OTA |

## Getting Started

**Prerequisites**: Flutter SDK (>=3.11.1), Melos 7.x

```bash
# Install Melos globally
dart pub global activate melos

# Bootstrap the workspace (install deps, link local packages)
melos bootstrap
```

## Development

```bash
# Run static analysis across all packages
melos run analyze

# Run tests across all packages
melos run test

# Check formatting
melos run format

# Clean all packages
melos run clean

# Run a single app
cd apps/elogir_alarm && flutter run

# Regenerate code (Freezed, Drift, Riverpod, go_router)
cd apps/elogir_alarm && dart run build_runner build --delete-conflicting-outputs
```

## Architecture

All apps follow a consistent architecture:

- **State management**: Riverpod with `riverpod_generator`
- **Data classes**: Freezed (immutable models with unions, copyWith, JSON serialization)
- **Routing**: go_router with `go_router_builder` (type-safe, declarative)
- **Local database**: Drift (SQLite), always the local source of truth
- **UI**: elogir_ui design system (no Material/Cupertino)
- **Logging**: Talker with Riverpod and Dio integration
- **Icons**: FontAwesome (no Material Icons)

### Data Flow

```
UI + Providers  -->  Repository (read/write)  -->  Drift (SQLite)
```

Drift is always the source of truth. Repositories handle all mapping between Drift rows and Freezed domain models. Apps never interact with the database directly.

### Responsive Layout

All apps support three form factors:

| Size | Width | Navigation |
|------|-------|------------|
| Compact | < 600dp | Bottom navigation |
| Medium | 600--839dp | Navigation rail |
| Expanded | >= 840dp | Persistent sidebar |

## Monorepo Structure

```
elogir-monorepo/
├── apps/
│   ├── elogir_alarm/
│   ├── elogir_calc/
│   ├── elogir_home/
│   └── elogir_notes/
├── packages/
│   ├── elogir_auto/
│   ├── elogir_ui/
│   └── elogir_updater/
├── pubspec.yaml          # Workspace definition + Melos config
└── CLAUDE.md             # AI coding assistant context
```

Uses Melos 7.x with Dart pub workspaces. Packages are auto-discovered via workspace globs (`packages/**`, `apps/**`). Each package declares `resolution: workspace` in its pubspec.

## Adding a New App or Package

1. Create the directory under `apps/` or `packages/`
2. Add `resolution: workspace` to its `pubspec.yaml`
3. Run `melos bootstrap`

## Commit Convention

Uses [Conventional Commits](https://www.conventionalcommits.org/) for automatic version bumping:

```
feat(elogir_alarm): add snooze duration setting
fix(elogir_ui): text field hint alignment
chore(root): update workspace dependencies
```
