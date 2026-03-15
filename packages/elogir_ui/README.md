# elogir_ui

Flutter UI component library with a "Soft Industrial" design language. Built entirely from Flutter primitives -- zero Material or Cupertino imports. Thick borders for depth, warm neutrals, generous spacing, and scale-down press animations.

Part of the [elogir monorepo](../../README.md).

## Design Principles

- **No Material/Cupertino** -- only `package:flutter/widgets.dart`, `services.dart`, and `painting.dart`
- **Borders over shadows** -- thick borders are the primary depth mechanism
- **Warm neutrals** -- neutral grays with warm undertones
- **Heavy typography** -- heavier-than-Material font weights
- **Press-to-scale** -- interactive elements scale down on press via `ElogirPressable`

## Components

### Theme
`ElogirThemeData` distributed via `ElogirTheme` InheritedWidget. Composed of token classes: colors, typography, spacing, radii, shadows, strokes, and durations. Supports light/dark mode and custom extensions via `ElogirThemeExtension<T>`.

### Widgets

| Category | Components |
|----------|------------|
| **App** | `ElogirApp`, `ElogirScaffold`, `ElogirAppBar` |
| **Interaction** | `ElogirPressable` (foundation for all interactive widgets) |
| **Buttons** | `ElogirButton`, `ElogirIconButton` |
| **Forms** | `ElogirTextField`, `ElogirDropdown`, `ElogirDatePicker`, `ElogirSearchField` |
| **Toggles** | `ElogirCheckbox`, `ElogirSwitch`, `ElogirSlider` |
| **Surfaces** | `ElogirCard`, `ElogirGlassMorphism` |
| **Data display** | `ElogirAvatar`, `ElogirBadge`, `ElogirTag`, `ElogirStatCard`, `ElogirTimeline`, `ElogirDataTable` |
| **Navigation** | `ElogirBottomNav`, `ElogirPopupMenu`, `ElogirBreadcrumb`, `ElogirCommandPalette`, `ElogirTabBar` |
| **Feedback** | `ElogirDialog`, `ElogirBottomSheet`, `ElogirToast`, `ElogirSpinner`, `ElogirProgressBar`, `ElogirTooltip` |
| **Layout** | `ElogirAccordion` |
| **Animation** | Fade-in, parallax, marquee, typewriter, staggered list, animated counter, pulse |

## Usage

```dart
import 'package:elogir_ui/elogir_ui.dart';

// Wrap your app
ElogirApp(
  lightTheme: ElogirThemeData.light(),
  darkTheme: ElogirThemeData.dark(),
  home: const MyHomePage(),
);

// Access theme tokens
final theme = ElogirTheme.of(context);
final primary = theme.colors.primary;
final heading = theme.typography.headingLarge;

// Use components
ElogirButton(
  label: 'Save',
  onPressed: () => save(),
);
```

## Example App

The `example/` directory contains a fully functional demo showcasing all widgets with light/dark theme toggle. Sets `uses-material-design: false` to validate the zero-Material constraint.
