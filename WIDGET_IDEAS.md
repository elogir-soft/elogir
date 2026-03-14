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
- [x] ElogirTooltip — hover/long-press overlay positioned above/below/left/right
- [x] ElogirToast — non-modal stacking notifications with auto-dismiss, variant icons

### Forms (continued)

- [x] ElogirSearchField — search field with magnifying glass icon and clear button
- [x] ElogirRadioGroup — custom radio buttons with animated selection dot, group management
- [x] ElogirDropdown — overlay-based picker with hover highlight, selected check mark
- [x] ElogirMultiDropdown — multi-select dropdown with checkboxes, overlay stays open during selection
- [x] ElogirSlider — slider with value tooltip, optional divisions
- [x] ElogirCalendar — standalone calendar widget with single/range/multi modes, embeddable anywhere
- [x] ElogirDatePicker — overlay calendar with month navigation, day selection, today highlight

### Layout (continued)

- [x] ElogirAccordion — animated expand/collapse with header, chevron, single or multi-open modes
- [x] ElogirAccordionGroup — coordinated accordion container with single-open behavior

### Navigation (continued)

- [x] ElogirBreadcrumb — path-style navigation with chevron separators
- [x] ElogirTabBar — tab strip with animated underline/pill indicator that slides between tabs
- [x] ElogirBottomNav — mobile bottom bar with animated icon transitions on selection
- [x] ElogirCommandPalette — Cmd+K style overlay with search field, keyboard navigation, action groups
- [x] ElogirPageTransition — route transition builder with fade, slide, scale, and fadeScale types

### Data Display (continued)

- [x] ElogirTimeline — vertical sequence with dots, connectors, title/subtitle/content
- [x] ElogirStatCard — number + label + trend arrow for dashboards
- [x] ElogirDataTable — sortable columns, row selection, thick-bordered header/rows, hover highlights

### Feedback (continued)

- [x] ElogirDrawer — slide-in panel from any edge with scrim overlay
- [x] ElogirBottomSheet — draggable sheet with handle bar, drag-to-dismiss
- [x] ElogirPopover — anchored floating panel with arbitrary content, barrier dismissible

### Utility (continued)

- [x] ElogirAnimatedList — staggered fade + slide-in animations for child widgets

---

## Future Widget Ideas

### High Priority

- [ ] ElogirListTile — row with leading/title/subtitle/trailing, workhorse for list-based UIs
- [ ] ElogirIconButton — icon-only button variant
- [ ] ElogirSideNav — sidebar navigation for desktop/tablet layouts
- [ ] ElogirMenu — context menu / action menu with overlay positioning
- [ ] ElogirPagination — page controls for tables and lists
- [ ] ElogirStepper — multi-step wizard/form flow with progress indicator
- [ ] ElogirBanner — persistent inline notification bar (vs transient Toast)
- [ ] ElogirChipInput — text field that converts entries into tags (email fields, etc.)
- [ ] ElogirTimePicker — time selection companion to ElogirDatePicker

### Medium Priority

- [ ] ElogirEmptyState — placeholder for "no data" / "no results" screens
- [ ] ElogirTreeView — hierarchical expandable list
- [ ] ElogirSplitPane — resizable side-by-side panels for desktop layouts
- [ ] ElogirCarousel — horizontal paged content with indicators
- [ ] ElogirPinInput — OTP/verification code input fields
- [ ] ElogirNumberStepper — increment/decrement number field
- [ ] ElogirResponsiveLayout — breakpoint-aware column/grid system

### Nice to Have

- [ ] ElogirColorPicker — color selection widget
- [ ] ElogirInfiniteScroll — lazy-loading list wrapper with loading indicator
- [ ] ElogirSortableList — drag-to-reorder list
- [ ] ElogirImageCropper — image crop/edit widget

---

## Animations

### Public Animation Widgets (`lib/src/animations/`)

Reusable animation wrappers consumers can use in their own apps.

- [x] ElogirFadeIn — fade + optional slide on first build, configurable direction/delay
- [x] ElogirAnimatedVisibility — enter/exit transitions (fade, slide, scale) when showing/hiding a child
- [x] ElogirStaggeredList — applies offset delays to children for cascading entrance animations
- [x] ElogirAnimatedCounter — number ticker that rolls digits on value change
- [x] ElogirTypewriter — text that types itself out character by character
- [x] ElogirMarquee — continuous horizontal scroll for overflowing text
- [x] ElogirAnimatedSwap — cross-fade/slide between two widgets when child changes (like AnimatedSwitcher but opinionated)
- [x] ElogirSpringContainer — physics-based bounce on size/position changes
- [x] ElogirAnimatedGradient — smoothly transitioning background gradient
- [x] ElogirPulse — repeating scale or opacity pulse (for attention-drawing)
- [x] ElogirParallax — scroll-linked offset for depth effect in lists

### Public Curve Presets (`lib/src/animations/curves.dart`)

Custom easing curves tuned for Soft Industrial feel — snappy but not bouncy.

- [x] ElogirCurves.snappy — fast start, firm stop (main interaction curve)
- [x] ElogirCurves.gentle — slow ease-in-out for ambient/background motion
- [x] ElogirCurves.spring — light overshoot for playful feedback
- [x] ElogirCurves.decelerate — fast entry, long settle (overlays appearing)

### Internal Widget Polish

Small animation details to add to existing widgets — not separate components, just improvements.

#### Forms
- [x] ElogirTextField — error shake animation on validation failure
- [x] ElogirTextField — floating label color transition on focus (already had AnimatedDefaultTextStyle)
- [x] ElogirCheckbox — subtle scale bounce on check/uncheck
- [x] ElogirSwitch — thumb bounce at end of travel (easeOutBack curve)
- [x] ElogirSlider — value tooltip fade + scale on grab/release
- [x] ElogirDropdown / ElogirMultiDropdown — chevron rotation on open/close (already had AnimatedRotation)

#### Feedback
- [x] ElogirToast — slide-in from edge + fade-out on dismiss (already implemented)
- [x] ElogirDialog — scale + fade entrance, reverse on exit (already implemented)
- [x] ElogirBottomSheet — velocity-based fling-to-dismiss (already implemented)
- [ ] ElogirDrawer — parallax offset on content behind scrim
- [x] ElogirProgressBar — shine sweep on completion (100%)
- [ ] ElogirSpinner — smooth start/stop rather than abrupt appear/disappear

#### Data Display
- [x] ElogirBadge — scale pop when count changes
- [x] ElogirAvatar — status dot pulse for "online" state
- [ ] ElogirTag — scale + fade on add/remove
- [x] ElogirStatCard — animated number count-up on first appearance
- [ ] ElogirDataTable — row highlight fade on hover, sort arrow flip

#### Navigation
- [ ] ElogirTabBar — indicator stretch/squash while sliding between tabs (rubber band)
- [x] ElogirBottomNav — icon scale bump + label fade on selection
- [ ] ElogirBreadcrumb — new segment slide-in from right

#### Layout
- [x] ElogirAccordion — content fade-in as it expands (not just height)
- [ ] ElogirAppBar — shadow/border appearance on scroll

#### Buttons
- [x] ElogirButton — loading state transition (label cross-fades to spinner)
