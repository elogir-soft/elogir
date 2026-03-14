import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// Avatar size presets.
enum ElogirAvatarSize { xs, sm, md, lg, xl }

/// Displays a user avatar as a network image, local image, initials,
/// or fallback icon.
///
/// Supports [imageUrl] via cached_network_image for network images,
/// [imageProvider] for local/asset images, or [initials] for text.
/// Optional status indicator dot in the bottom-right corner.
class ElogirAvatar extends StatelessWidget {
  const ElogirAvatar({
    super.key,
    this.imageUrl,
    this.imageProvider,
    this.initials,
    this.child,
    this.size = ElogirAvatarSize.md,
    this.customSize,
    this.backgroundColor,
    this.foregroundColor,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.showStatus = false,
    this.isOnline = false,
  });

  final String? imageUrl;
  final ImageProvider? imageProvider;
  final String? initials;
  final Widget? child;
  final ElogirAvatarSize size;
  final double? customSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final bool showStatus;
  final bool isOnline;

  double get _resolvedSize {
    if (customSize != null) return customSize!;
    switch (size) {
      case ElogirAvatarSize.xs:
        return 24;
      case ElogirAvatarSize.sm:
        return 32;
      case ElogirAvatarSize.md:
        return 40;
      case ElogirAvatarSize.lg:
        return 56;
      case ElogirAvatarSize.xl:
        return 72;
    }
  }

  double get _fontSize {
    switch (size) {
      case ElogirAvatarSize.xs:
        return 10;
      case ElogirAvatarSize.sm:
        return 12;
      case ElogirAvatarSize.md:
        return 16;
      case ElogirAvatarSize.lg:
        return 22;
      case ElogirAvatarSize.xl:
        return 28;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final dimension = _resolvedSize;
    final bg = backgroundColor ?? colors.primaryContainer;
    final fg = foregroundColor ?? colors.onPrimaryContainer;

    Widget content;
    if (imageUrl != null) {
      content = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: dimension,
        height: dimension,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildFallback(fg),
        errorWidget: (context, url, error) => _buildFallback(fg),
      );
    } else if (imageProvider != null) {
      content = Image(
        image: imageProvider!,
        width: dimension,
        height: dimension,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(fg),
      );
    } else if (child != null) {
      content = IconTheme(
        data: IconThemeData(color: fg, size: dimension * 0.5),
        child: child!,
      );
    } else {
      content = _buildFallback(fg);
    }

    Widget avatar = Container(
      width: dimension,
      height: dimension,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? (borderRadius ?? theme.radii.md)
            : null,
        border: Border.all(
          color: colors.outlineVariant,
          width: theme.strokes.medium,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    if (showStatus) {
      final dotSize = dimension * 0.28;
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: isOnline ? colors.success : colors.onSurfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.surface,
                  width: theme.strokes.thick,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return avatar;
  }

  Widget _buildFallback(Color fg) {
    return Text(
      initials?.toUpperCase() ?? '?',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: fg,
        fontSize: _fontSize,
        fontWeight: FontWeight.w700,
        height: 1.0,
      ),
    );
  }
}
