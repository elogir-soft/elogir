import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';

/// Displays all semantic theme colors in a grid layout.
///
/// Useful during development to preview light and dark theme colors
/// at a glance. Each tile shows the color swatch and its token name.
class ElogirThemeShowcase extends StatelessWidget {
  const ElogirThemeShowcase({super.key, this.tileSize = 56.0});

  final double tileSize;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _group(theme, 'Primary', [
          _Entry(colors.primary, 'primary'),
          _Entry(colors.onPrimary, 'onPrimary'),
          _Entry(colors.primaryContainer, 'primaryContainer'),
          _Entry(colors.onPrimaryContainer, 'onPrimaryContainer'),
        ]),
        SizedBox(height: theme.spacing.md),
        _group(theme, 'Surface', [
          _Entry(colors.surface, 'surface'),
          _Entry(colors.onSurface, 'onSurface'),
          _Entry(colors.surfaceContainer, 'surfaceContainer'),
          _Entry(colors.onSurfaceVariant, 'onSurfaceVariant'),
        ]),
        SizedBox(height: theme.spacing.md),
        _group(theme, 'Background', [
          _Entry(colors.background, 'background'),
          _Entry(colors.onBackground, 'onBackground'),
        ]),
        SizedBox(height: theme.spacing.md),
        _group(theme, 'Status', [
          _Entry(colors.error, 'error'),
          _Entry(colors.onError, 'onError'),
          _Entry(colors.success, 'success'),
          _Entry(colors.warning, 'warning'),
        ]),
        SizedBox(height: theme.spacing.md),
        _group(theme, 'Outline & Utility', [
          _Entry(colors.outline, 'outline'),
          _Entry(colors.outlineVariant, 'outlineVariant'),
          _Entry(colors.disabled, 'disabled'),
          _Entry(colors.onDisabled, 'onDisabled'),
        ]),
      ],
    );
  }

  Widget _group(ElogirThemeData theme, String title, List<_Entry> entries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.typography.labelLarge.copyWith(
            color: theme.colors.onBackground,
          ),
        ),
        SizedBox(height: theme.spacing.xs),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: entries
              .map((e) => _tile(theme, e.color, e.name))
              .toList(),
        ),
      ],
    );
  }

  Widget _tile(ElogirThemeData theme, Color color, String name) {
    final hex =
        '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    return SizedBox(
      width: tileSize + 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: tileSize,
            height: tileSize,
            decoration: BoxDecoration(
              color: color,
              borderRadius: theme.radii.md,
              border: Border.all(
                color: theme.colors.outlineVariant,
                width: theme.strokes.medium,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: theme.typography.caption.copyWith(
              color: theme.colors.onBackground,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            hex,
            style: theme.typography.caption.copyWith(
              color: theme.colors.onSurfaceVariant,
              fontSize: 9,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Entry {
  const _Entry(this.color, this.name);
  final Color color;
  final String name;
}
