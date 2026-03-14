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

---

## Future Widget Ideas

### Navigation & Structure

- [ ] ElogirSidebar — collapsible side nav with icon+label items, nested groups, active indicator animation
- [ ] ElogirTabBar — tab strip with animated underline/pill indicator that slides between tabs
- [ ] ElogirBreadcrumb — path-style navigation with separators, truncation for deep paths
- [ ] ElogirBottomNav — mobile bottom bar with animated icon transitions on selection
- [ ] ElogirCommandPalette — Cmd+K style overlay with fuzzy search, keyboard navigation, action groups
- [ ] ElogirDrawer — slide-in panel from any edge, with overlay

### Data Display

- [ ] ElogirDataTable — sortable columns, row selection, sticky headers, virtual scrolling
- [ ] ElogirTimeline — vertical sequence of events with connectors, icons, timestamps
- [ ] ElogirStatCard — number + label + trend arrow/sparkline for dashboards

### Forms

- [ ] ElogirSearchField — text field with clear button, search icon, debounced onChanged
- [ ] ElogirRadioGroup — custom radio buttons with group management
- [ ] ElogirDropdown — overlay-based picker, searchable, multi-select variant
- [ ] ElogirSlider — range slider with tooltip showing current value
- [ ] ElogirDatePicker — calendar overlay, range selection

### Feedback & Overlay

- [ ] ElogirToast — non-modal stacking notifications with auto-dismiss, swipe-to-dismiss
- [ ] ElogirBottomSheet — draggable sheet with snap points, handle bar
- [ ] ElogirTooltip — hover/long-press overlay with arrow pointing to target
- [ ] ElogirSkeleton — shimmer loading placeholder matching content shape
- [ ] ElogirProgressBar — determinate/indeterminate with animated fill, optional label
- [ ] ElogirSpinner — custom loading indicator (distinctive to elogir brand)
- [ ] ElogirPopover — anchored floating panel with arbitrary content

### Layout

- [ ] ElogirAccordion — animated expand/collapse with header, single or multi-open modes

### Micro-interactions

- [ ] ElogirAnimatedList — staggered entry animations when items appear
- [ ] ElogirPageTransition — shared-element-style transitions between routes
