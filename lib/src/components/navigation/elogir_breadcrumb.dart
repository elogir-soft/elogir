import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A single breadcrumb item.
class ElogirBreadcrumbItem {
  const ElogirBreadcrumbItem({
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;
}

/// Path-style breadcrumb navigation with separators.
///
/// The last item is styled as the current (active) page with bolder weight.
/// Previous items show an underline on hover and are pressable links.
class ElogirBreadcrumb extends StatelessWidget {
  const ElogirBreadcrumb({
    super.key,
    required this.items,
    this.separator,
  });

  final List<ElogirBreadcrumbItem> items;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return Semantics(
      label: 'Breadcrumb navigation',
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.xs + theme.spacing.xxs),
                child: separator ??
                    Text(
                      '/',
                      style: theme.typography.bodySmall.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
              ),
            if (i == items.length - 1)
              Text(
                items[i].label,
                style: theme.typography.labelLarge.copyWith(
                  color: colors.onSurface,
                ),
              )
            else
              _BreadcrumbLink(item: items[i]),
          ],
        ],
      ),
    );
  }
}

class _BreadcrumbLink extends StatefulWidget {
  const _BreadcrumbLink({required this.item});

  final ElogirBreadcrumbItem item;

  @override
  State<_BreadcrumbLink> createState() => _BreadcrumbLinkState();
}

class _BreadcrumbLinkState extends State<_BreadcrumbLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return ElogirPressable(
      onPressed: widget.item.onPressed,
      onHoverChanged: (v) => setState(() => _hovered = v),
      pressScale: 0.97,
      child: Text(
        widget.item.label,
        style: theme.typography.labelMedium.copyWith(
          color: colors.onSurfaceVariant,
          decoration: _hovered ? TextDecoration.underline : TextDecoration.none,
          decorationColor: colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
