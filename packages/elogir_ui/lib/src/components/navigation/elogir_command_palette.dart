import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';
import '../interaction/elogir_pressable.dart';

/// A single action available in the command palette.
class ElogirCommandAction {
  const ElogirCommandAction({
    required this.label,
    required this.onAction,
    this.group,
    this.keywords = const [],
    this.shortcutLabel,
  });

  /// Display text (also used for search matching).
  final String label;

  /// Called when this action is selected.
  final VoidCallback onAction;

  /// Optional group header (e.g. "Navigation", "Settings").
  /// Actions with the same group are grouped together.
  final String? group;

  /// Additional search terms that match this action.
  final List<String> keywords;

  /// Optional keyboard shortcut to display (e.g. "⌘K").
  final String? shortcutLabel;
}

/// A Cmd+K style overlay for searching and executing actions.
///
/// Soft Industrial style: thick-bordered floating panel with a search field,
/// filtered action list, and keyboard navigation (↑/↓ + Enter).
///
/// ```dart
/// ElogirCommandPalette.show(
///   context: context,
///   actions: [
///     ElogirCommandAction(
///       label: 'Open Settings',
///       group: 'Navigation',
///       onAction: () => Navigator.push(...),
///     ),
///     ElogirCommandAction(
///       label: 'Toggle Theme',
///       group: 'Appearance',
///       shortcutLabel: '⌘T',
///       onAction: () => toggleTheme(),
///     ),
///   ],
/// );
/// ```
class ElogirCommandPalette {
  ElogirCommandPalette._();

  /// Shows the command palette as a modal overlay.
  static void show({
    required BuildContext context,
    required List<ElogirCommandAction> actions,
    String placeholder = 'Type a command…',
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: ElogirTheme.of(context).colors.barrier,
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: _CommandPaletteContent(
              actions: actions,
              placeholder: placeholder,
            ),
          );
        },
      ),
    );
  }
}

class _CommandPaletteContent extends StatefulWidget {
  const _CommandPaletteContent({
    required this.actions,
    required this.placeholder,
  });

  final List<ElogirCommandAction> actions;
  final String placeholder;

  @override
  State<_CommandPaletteContent> createState() => _CommandPaletteContentState();
}

class _CommandPaletteContentState extends State<_CommandPaletteContent> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late List<ElogirCommandAction> _filtered;
  int _highlightedIndex = 0;

  @override
  void initState() {
    super.initState();
    _filtered = widget.actions;
    _searchController.addListener(_onSearchChanged);
    // Auto-focus the search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filtered = widget.actions;
      } else {
        _filtered = widget.actions.where((action) {
          if (action.label.toLowerCase().contains(query)) return true;
          for (final kw in action.keywords) {
            if (kw.toLowerCase().contains(query)) return true;
          }
          if (action.group != null &&
              action.group!.toLowerCase().contains(query)) {
            return true;
          }
          return false;
        }).toList();
      }
      _highlightedIndex = _filtered.isEmpty ? -1 : 0;
    });
  }

  void _executeHighlighted() {
    if (_highlightedIndex >= 0 && _highlightedIndex < _filtered.length) {
      final action = _filtered[_highlightedIndex];
      Navigator.of(context).pop();
      action.onAction();
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _highlightedIndex = (_highlightedIndex + 1).clamp(0, _filtered.length - 1);
      });
      return KeyEventResult.handled;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _highlightedIndex = (_highlightedIndex - 1).clamp(0, _filtered.length - 1);
      });
      return KeyEventResult.handled;
    }

    if (event.logicalKey == LogicalKeyboardKey.enter) {
      _executeHighlighted();
      return KeyEventResult.handled;
    }

    if (event.logicalKey == LogicalKeyboardKey.escape) {
      Navigator.of(context).pop();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    // Build grouped display list
    final displayItems = _buildDisplayItems();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: Align(
        alignment: const Alignment(0, -0.3),
        child: GestureDetector(
          onTap: () {}, // absorb taps on the palette itself
          child: Focus(
            onKeyEvent: _handleKeyEvent,
            child: Container(
              width: 480,
              constraints: const BoxConstraints(maxHeight: 400),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: theme.radii.lg,
                border: Border.all(
                  color: colors.outline,
                  width: theme.strokes.thick,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    (theme.radii.lg.topLeft.x - theme.strokes.thick)
                        .clamp(0, double.infinity),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search field
                    _SearchBar(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      placeholder: widget.placeholder,
                      theme: theme,
                    ),
                    // Divider
                    Container(
                      height: theme.strokes.thin,
                      color: colors.outlineVariant,
                    ),
                    // Results
                    if (displayItems.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(theme.spacing.lg),
                        child: Text(
                          'No results found',
                          style: theme.typography.bodyMedium.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      )
                    else
                      Flexible(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            vertical: theme.spacing.xs,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: displayItems,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDisplayItems() {
    final theme = ElogirTheme.of(context);
    final items = <Widget>[];
    String? lastGroup;
    int actionIndex = 0;

    for (final action in _filtered) {
      // Group header
      if (action.group != null && action.group != lastGroup) {
        lastGroup = action.group;
        items.add(
          Padding(
            padding: EdgeInsets.only(
              left: theme.spacing.md,
              right: theme.spacing.md,
              top: items.isEmpty ? theme.spacing.xs : theme.spacing.sm,
              bottom: theme.spacing.xs,
            ),
            child: Text(
              action.group!,
              style: theme.typography.caption.copyWith(
                color: theme.colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      }

      final currentIndex = actionIndex;
      items.add(
        _ActionItem(
          action: action,
          isHighlighted: currentIndex == _highlightedIndex,
          theme: theme,
          onTap: () {
            Navigator.of(context).pop();
            action.onAction();
          },
          onHover: () {
            setState(() => _highlightedIndex = currentIndex);
          },
        ),
      );
      actionIndex++;
    }

    return items;
  }
}

// ─── Search Bar ───────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.focusNode,
    required this.placeholder,
    required this.theme,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String placeholder;
  final ElogirThemeData theme;

  @override
  Widget build(BuildContext context) {
    final colors = theme.colors;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.sm,
      ),
      child: Row(
        children: [
          // Search icon
          CustomPaint(
            size: const Size(16, 16),
            painter: _SearchIconPainter(
              color: colors.onSurfaceVariant,
              strokeWidth: theme.strokes.medium,
            ),
          ),
          SizedBox(width: theme.spacing.sm),
          Expanded(
            child: EditableText(
              controller: controller,
              focusNode: focusNode,
              style: theme.typography.bodyMedium.copyWith(
                color: colors.onSurface,
              ),
              cursorColor: colors.primary,
              backgroundCursorColor: colors.surfaceContainer,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Action Item ──────────────────────────────────────────────────

class _ActionItem extends StatefulWidget {
  const _ActionItem({
    required this.action,
    required this.isHighlighted,
    required this.theme,
    required this.onTap,
    required this.onHover,
  });

  final ElogirCommandAction action;
  final bool isHighlighted;
  final ElogirThemeData theme;
  final VoidCallback onTap;
  final VoidCallback onHover;

  @override
  State<_ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<_ActionItem> {
  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    return ElogirPressable(
      onPressed: widget.onTap,
      onHoverChanged: (hovered) {
        if (hovered) widget.onHover();
      },
      pressScale: 1.0,
      child: AnimatedContainer(
        duration: widget.theme.durations.fast,
        padding: EdgeInsets.symmetric(
          horizontal: widget.theme.spacing.md,
          vertical: widget.theme.spacing.sm,
        ),
        color: widget.isHighlighted
            ? colors.surfaceContainer
            : colors.surface,
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.action.label,
                style: widget.theme.typography.bodyMedium.copyWith(
                  color: colors.onSurface,
                ),
              ),
            ),
            if (widget.action.shortcutLabel != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.theme.spacing.xs + widget.theme.spacing.xxs,
                  vertical: widget.theme.spacing.xxs,
                ),
                decoration: BoxDecoration(
                  borderRadius: widget.theme.radii.sm,
                  border: Border.all(
                    color: colors.outlineVariant,
                    width: widget.theme.strokes.thin,
                  ),
                ),
                child: Text(
                  widget.action.shortcutLabel!,
                  style: widget.theme.typography.caption.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Custom Painters ──────────────────────────────────────────────

class _SearchIconPainter extends CustomPainter {
  _SearchIconPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Circle
    final center = Offset(size.width * 0.4, size.height * 0.4);
    final radius = size.width * 0.3;
    canvas.drawCircle(center, radius, paint);

    // Handle
    final handleStart = Offset(
      center.dx + radius * 0.7,
      center.dy + radius * 0.7,
    );
    canvas.drawLine(
      handleStart,
      Offset(size.width * 0.9, size.height * 0.9),
      paint,
    );
  }

  @override
  bool shouldRepaint(_SearchIconPainter old) => color != old.color;
}
