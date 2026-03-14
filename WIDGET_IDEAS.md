# elogir_ui Widget Ideas & Roadmap

## Visual Identity: Soft Industrial

Rounded but with weight. Thick borders, generous padding, muted warm colors with one bold accent.
Shadows are subtle or absent — depth comes from borders and layering.

### Design Principles

- **Thick strokes**: 1.5–2px borders define edges instead of shadows
- **Warm neutrals**: slightly warm-shifted grays, never pure gray
- **Generous spacing**: elements breathe, nothing feels cramped
- **Measured typography**: confident but not loud — heavier weights, tighter letter spacing, restrained sizes
- **Subtle animation**: scale-down on press, smooth transitions, no bounce
- **Accessible**: every interactive element has semantics, focus, and keyboard support

---

## Implemented Widgets

### Theme System

- [x] ElogirColorPalette — raw color values with warm neutrals
- [x] ElogirColors — semantic color mapping (light/dark)
- [x] ElogirTypography — 16 text styles, weighted for Soft Industrial
- [x] ElogirSpacing — consistent whitespace tokens
- [x] ElogirRadii — border radius tokens
- [x] ElogirShadows — subtle elevation tokens
- [x] ElogirStrokes — border width tokens (thin/medium/thick)
- [x] ElogirDurations — animation timing tokens
- [x] ElogirThemeData — composites all tokens
- [x] ElogirTheme — InheritedWidget distribution
- [x] ElogirThemeExtension — consumer-defined extensions

### App

- [x] ElogirApp — WidgetsApp wrapper with theme injection

### Interaction

- [x] ElogirPressable — base interaction widget with scale-down press effect

### Text

- [x] ElogirText — themed text with variant system

### Buttons

- [x] ElogirButton — filled/outlined/text variants with press animation

### Layout

- [x] ElogirScaffold — app bar + body layout
- [x] ElogirAppBar — top bar with leading/title/trailing

### Surfaces

- [x] ElogirCard — bordered surface container

### Forms

- [x] ElogirTextField — text input with floating label, error/helper text
- [x] ElogirCheckbox — custom-drawn checkbox with animated check mark
- [x] ElogirSwitch — toggle switch with animated thumb

### Data Display

- [x] ElogirAvatar — image/initials with optional status indicator
- [x] ElogirBadge — count/dot indicator that attaches to widgets
- [x] ElogirTag — removable/selectable label chip

### Utility

- [x] ElogirDivider — horizontal/vertical with optional label

### Navigation

- [x] ElogirSegmentedControl — pill-style toggle group with animated indicator

### Feedback

- [x] ElogirDialog — modal dialog with backdrop
- [x] ElogirProgressBar — determinate/indeterminate with animated fill, optional label
- [x] ElogirSpinner — custom loading indicator with thick arc rotation
- [x] ElogirSkeleton — pulse-animated loading placeholder (rectangle, circle, text variants)
- [x] ElogirTooltip — hover/long-press overlay positioned above/below/left/right
- [x] ElogirToast — non-modal stacking notifications with auto-dismiss, variant icons

### Forms (continued)

- [x] ElogirSearchField — search field with magnifying glass icon and clear button

### Layout (continued)

- [x] ElogirAccordion — animated expand/collapse with header, chevron, single or multi-open modes
- [x] ElogirAccordionGroup — coordinated accordion container with single-open behavior

---

## Future Widget Ideas

### Forms (continued)

- [x] ElogirRadioGroup — custom radio buttons with animated selection dot, group management

### Navigation (continued)

- [x] ElogirBreadcrumb — path-style navigation with chevron separators

### Data Display (continued)

- [x] ElogirTimeline — vertical sequence with dots, connectors, title/subtitle/content

### Feedback (continued)

- [x] ElogirDrawer — slide-in panel from any edge with scrim overlay
- [x] ElogirBottomSheet — draggable sheet with handle bar, drag-to-dismiss
- [x] ElogirPopover — anchored floating panel with arbitrary content, barrier dismissible

---

### Navigation & Structure (continued)

- [x] ElogirTabBar — tab strip with animated underline/pill indicator that slides between tabs
- [x] ElogirBottomNav — mobile bottom bar with animated icon transitions on selection

### Data Display (continued)

- [x] ElogirStatCard — number + label + trend arrow for dashboards

### Forms (continued)

- [x] ElogirDropdown — overlay-based picker with hover highlight, selected check mark
- [x] ElogirSlider — slider with value tooltip, optional divisions

---

## Batch 5 — Advanced Widgets

- [x] ElogirDataTable — sortable columns, row selection, thick-bordered header/rows, hover highlights
- [x] ElogirDatePicker — overlay calendar with month navigation, day selection, today highlight
- [x] ElogirAnimatedList — staggered fade + slide-in animations for child widgets
- [x] ElogirCommandPalette — Cmd+K style overlay with search field, keyboard navigation, action groups
- [x] ElogirPageTransition — route transition builder with fade, slide, scale, and fadeScale types
