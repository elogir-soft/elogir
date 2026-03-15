# elogir_home

Smart home app for controlling and automating IoT devices. Currently supports Tuya-compatible devices over LAN and Cloud API.

Part of the [elogir monorepo](../../README.md).

## Features

- **Device control** -- on/off, brightness, color temperature for lights; position for covers; toggle for switches
- **Device discovery** -- scan the local network for Tuya devices
- **Device setup** -- configure device connections and assign rooms
- **Automation** -- set up device automations with reactive event streams
- **Settings** -- theme mode, Tuya credentials

## Tech Stack

- **UI**: [elogir_ui](../../packages/elogir_ui) design system
- **Smart devices**: [elogir_auto](../../packages/elogir_auto) library (Tuya LAN + Cloud API)
- **State management**: Riverpod with code generation
- **Reactive streams**: RxDart for device state and automation events
- **Database**: Drift (SQLite) for device persistence
- **Routing**: go_router with type-safe route generation
- **Auto-update**: [elogir_updater](../../packages/elogir_updater) for OTA updates via GitHub Releases
