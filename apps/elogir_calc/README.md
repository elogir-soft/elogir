# elogir_calc

Calculator app with basic and scientific modes, real-time expression preview, and calculation history.

Part of the [elogir monorepo](../../README.md).

## Features

- **Basic calculator** -- standard arithmetic with a 4x5 button grid
- **Scientific mode** -- trigonometry (sin/cos/tan), logarithms, constants (pi, e), parentheses, degrees/radians toggle
- **Expression preview** -- real-time result preview as you type
- **History** -- persistent calculation history stored in Drift
- **Settings** -- theme mode, default calculator mode

## Tech Stack

- **UI**: [elogir_ui](../../packages/elogir_ui) design system
- **State management**: Riverpod with code generation
- **Database**: Drift (SQLite) for calculation history
- **Routing**: go_router with type-safe route generation
- **Auto-update**: [elogir_updater](../../packages/elogir_updater) for OTA updates via GitHub Releases
