# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

elogir_ui is a Flutter UI component library built entirely from Flutter primitives (`package:flutter/widgets.dart`). It uses **zero Material or Cupertino imports**. The only external dependency is `cached_network_image` (for avatar network images). The visual identity is "Soft Industrial" — thick borders for depth instead of shadows, warm neutral grays, generous spacing, heavier typography weights, and scale-down press animations.

## Commands

```bash
# Analyze (from project root — covers both lib/ and example/)
flutter analyze

# Run tests (example app has the widget tests)
cd example && flutter test

# Run a single test file
cd example && flutter test test/widget_test.dart

# Get dependencies after pubspec changes
flutter pub get
cd example && flutter pub get
```

There is no build step, CI/CD, or custom scripts.

## Architecture

### Theme System (`lib/src/theme/`)

All styling flows through `ElogirThemeData`, distributed via `ElogirTheme` (an `InheritedWidget`). Widgets access it with `ElogirTheme.of(context)`.

The theme composes these token classes:
- **ElogirColorPalette** → raw colors (primary 50-900, warm neutrals, status colors)
- **ElogirColors** → semantic mapping from palette (`.light()` / `.dark()` factories)
- **ElogirTypography** → 16 named text styles with heavier-than-Material weights
- **ElogirSpacing** / **ElogirRadii** / **ElogirShadows** / **ElogirStrokes** / **ElogirDurations** → layout and animation tokens

Apps can inject custom tokens via `ElogirThemeExtension<T>`.

### Widget Patterns

Every interactive widget uses **ElogirPressable** as its interaction foundation. It provides scale-down press animation, hover/focus detection via `FocusableActionDetector`, and `Semantics` wrapping. New interactive widgets should compose it rather than reimplementing gesture/focus handling.

Components follow this structure:
1. Accept theme overrides as optional parameters
2. Read defaults from `ElogirTheme.of(context)`
3. Use `AnimatedContainer` / `AnimatedPositioned` for state transitions
4. Include `Semantics` for accessibility
5. Co-locate variant/size enums with their widget (e.g., `ElogirButtonVariant` lives in `elogir_button.dart`)

### Barrel Export (`lib/elogir_ui.dart`)

Every public widget/class must be exported here, organized by category (theme, app, interaction, buttons, forms, layout, surfaces, data display, navigation, utility, feedback).

## Key Constraints

- **No `package:flutter/material.dart` or `package:flutter/cupertino.dart` imports in `lib/`**. Use only `package:flutter/widgets.dart`, `package:flutter/services.dart`, `package:flutter/painting.dart`, and `dart:ui`.
- **`TextStyle` must come from `package:flutter/widgets.dart`**, not `dart:ui` (they are different classes; the dart:ui version lacks `copyWith`).
- **Borders are the primary depth mechanism**, not shadows. Default shadows should be `theme.shadows.none` on most surfaces.
- **`Container` with `alignment` expands to fill parent width**. Use `Align(widthFactor: 1.0)` inside the container instead when you want content centering without width expansion.

## Example App (`example/`)

Path-depends on the parent package (`elogir_ui: path: ../`). Sets `uses-material-design: false`. Demonstrates all widgets with a working light/dark theme toggle.
