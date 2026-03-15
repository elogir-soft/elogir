# elogir_alarm

Alarm clock app with alarms, timers, and a stopwatch. Uses native alarm scheduling for reliable background triggering on Android and iOS.

Part of the [elogir monorepo](../../README.md).

## Features

- **Alarms** -- schedule recurring or one-time alarms with native platform integration
- **Timers** -- countdown timers with background execution
- **Stopwatch** -- stopwatch with lap tracking
- **Settings** -- theme mode, notification preferences

## Tech Stack

- **UI**: [elogir_ui](../../packages/elogir_ui) design system
- **State management**: Riverpod with code generation
- **Database**: Drift (SQLite) for persisting alarms and timer configs
- **Routing**: go_router with type-safe route generation
- **Native alarms**: `alarm` + `flutter_alarmkit` for platform-level alarm scheduling
- **Background**: `wakelock_plus` and `permission_handler` for reliable background execution
- **Auto-update**: [elogir_updater](../../packages/elogir_updater) for OTA updates via GitHub Releases
