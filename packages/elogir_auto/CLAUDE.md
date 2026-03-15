# elogir_auto

Smart device control library for the elogir ecosystem. Extensible along two axes: **device types** (light, switch, cover) and **platforms** (Tuya now, Matter/HomeKit/Zigbee later).

## Architecture

```
ElogirAuto facade
  ↕
Abstract controllers (DeviceController / LightController / SwitchController / CoverController)
  ↕
Platform adapters (tuya/ — wraps tinytuya)
  ↕
tinytuya (LAN communication, Cloud API)
```

### Models

- `SmartDevice` — device identity + connection config
- `DeviceConnection` — Freezed union, one variant per platform (`TuyaConnection` now)
- State models per device type: `LightState`, `SwitchState`, `CoverState`
- `ScanResult` — discovered device from network scan
- `TuyaCredentials` — Tuya Cloud API credentials

### Controllers

Abstract controller hierarchy: `DeviceController<T>` → `LightController` / `SwitchController` / `CoverController`. Each uses rxdart `BehaviorSubject` for state streaming.

Tuya implementations: `TuyaDeviceController<T>` base → `TuyaLightController` / `TuyaSwitchController` / `TuyaCoverController`.

### Database

Self-contained Drift database (`AutoDatabase`) with `DeviceEntries` table and `DeviceDao`. The DAO maps between Drift rows and Freezed `SmartDevice` models, serializing `DeviceConnection` as JSON.

### Facade

`ElogirAuto` is the entry point. It caches controllers per device, auto-selects implementation based on connection type and device type. Device CRUD goes through `deviceDao` directly.

## Commands

```bash
# Regenerate code (Freezed + Drift)
dart run build_runner build --delete-conflicting-outputs

# Analyze
flutter analyze

# Test
flutter test
```

## Adding a New Platform

1. Add a new `DeviceConnection` union variant (e.g., `DeviceConnection.matter(...)`)
2. Create controller implementations in a new directory (e.g., `src/matter/`)
3. Add a case to `ElogirAuto._createController()` for the new connection type
4. The Drift database and DAO need no changes — `DeviceConnection` JSON handles it

## Adding a New Device Type

1. Add enum value to `DeviceType`
2. Create state model (e.g., `ThermostatState`)
3. Create abstract controller (e.g., `ThermostatController extends DeviceController<ThermostatState>`)
4. Add platform implementations (e.g., `TuyaThermostatController`)
5. Update `ElogirAuto._createController()` with the new type case
