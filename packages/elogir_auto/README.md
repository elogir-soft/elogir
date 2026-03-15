# elogir_auto

Smart device control library for IoT integration. Extensible along two axes: **device types** (light, switch, cover) and **platforms** (Tuya now, Matter/HomeKit/Zigbee later).

Part of the [elogir monorepo](../../README.md).

## Supported Devices

| Type | Capabilities |
|------|-------------|
| **Light** | On/off, brightness, color temperature |
| **Switch** | On/off toggle |
| **Cover** | Position control (blinds, shades) |

## Architecture

```
ElogirAuto (facade)
  |
Abstract controllers (DeviceController / LightController / SwitchController / CoverController)
  |
Platform adapters (tuya/ -- wraps tinytuya)
  |
tinytuya (LAN communication, Cloud API)
```

### Key Classes

- **`ElogirAuto`** -- facade entry point, caches controllers per device, auto-selects implementation based on connection type
- **`SmartDevice`** -- device identity + connection config (Freezed model)
- **`DeviceConnection`** -- Freezed union with one variant per platform (`TuyaConnection`)
- **Controllers** -- abstract hierarchy (`DeviceController<T>` -> `LightController` / `SwitchController` / `CoverController`) using RxDart `BehaviorSubject` for state streaming
- **`AutoDatabase`** -- self-contained Drift database with `DeviceDao` for offline persistence

## Usage

```dart
import 'package:elogir_auto/elogir_auto.dart';

// Initialize
final db = AutoDatabase();
final auto = ElogirAuto(deviceDao: db.deviceDao);

// Get a controller for a device
final controller = auto.getController(device);

// Stream device state
controller.stateStream.listen((state) {
  print('Device state: $state');
});

// Control a light
if (controller is LightController) {
  await controller.setBrightness(80);
  await controller.turnOn();
}
```

## Extending

### Adding a new platform

1. Add a `DeviceConnection` union variant (e.g., `DeviceConnection.matter(...)`)
2. Create controller implementations in a new directory (e.g., `src/matter/`)
3. Add a case to `ElogirAuto._createController()` for the new connection type
4. No database changes needed -- `DeviceConnection` JSON handles it

### Adding a new device type

1. Add enum value to `DeviceType`
2. Create state model (e.g., `ThermostatState`)
3. Create abstract controller (e.g., `ThermostatController extends DeviceController<ThermostatState>`)
4. Add platform implementations (e.g., `TuyaThermostatController`)
5. Update `ElogirAuto._createController()` with the new type case

## Development

```bash
# From monorepo root
melos bootstrap

# Regenerate code (Freezed + Drift)
dart run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Static analysis
dart analyze --fatal-infos
```
