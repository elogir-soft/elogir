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
class ElogirAvatar extends StatefulWidget {
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

  @override
  State<ElogirAvatar> createState() => _ElogirAvatarState();
}

class _ElogirAvatarState extends State<ElogirAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
    if (widget.isOnline && widget.showStatus) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(ElogirAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOnline && widget.showStatus) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      _pulseController.stop();
      _pulseController.value = 0.0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  double get _resolvedSize {
    if (widget.customSize != null) return widget.customSize!;
    switch (widget.size) {
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
    switch (widget.size) {
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
    final bg = widget.backgroundColor ?? colors.primaryContainer;
    final fg = widget.foregroundColor ?? colors.onPrimaryContainer;

    Widget content;
    if (widget.imageUrl != null) {
      content = CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        width: dimension,
        height: dimension,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildFallback(fg),
        errorWidget: (context, url, error) => _buildFallback(fg),
      );
    } else if (widget.imageProvider != null) {
      content = Image(
        image: widget.imageProvider!,
        width: dimension,
        height: dimension,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(fg),
      );
    } else if (widget.child != null) {
      content = IconTheme(
        data: IconThemeData(color: fg, size: dimension * 0.5),
        child: widget.child!,
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
        shape: widget.shape,
        borderRadius: widget.shape == BoxShape.rectangle
            ? (widget.borderRadius ?? theme.radii.md)
            : null,
        border: Border.all(
          color: colors.outlineVariant,
          width: theme.strokes.medium,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    if (widget.showStatus) {
      final dotSize = dimension * 0.28;
      final dotColor = widget.isOnline ? colors.success : colors.onSurfaceVariant;

      Widget statusDot;
      if (widget.isOnline) {
        statusDot = AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return SizedBox(
              width: dotSize * 1.6,
              height: dotSize * 1.6,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow ring
                    Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          color: dotColor.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Main status dot
                    Transform.scale(
                      scale: 1.0 + (_pulseAnimation.value - 1.0) * 0.3,
                      child: child,
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: colors.surface,
                width: theme.strokes.thick,
              ),
            ),
          ),
        );
      } else {
        statusDot = Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: colors.surface,
              width: theme.strokes.thick,
            ),
          ),
        );
      }

      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: -1,
            bottom: -1,
            child: statusDot,
          ),
        ],
      );
    }

    return avatar;
  }

  Widget _buildFallback(Color fg) {
    return Text(
      widget.initials?.toUpperCase() ?? '?',
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
