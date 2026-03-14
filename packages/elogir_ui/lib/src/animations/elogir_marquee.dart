import 'package:flutter/widgets.dart';

/// Continuously scrolls a child horizontally when it overflows.
///
/// Pauses briefly at each end before scrolling again.
///
/// ```dart
/// SizedBox(
///   width: 200,
///   child: ElogirMarquee(
///     child: Text('This is a very long text that overflows'),
///   ),
/// )
/// ```
class ElogirMarquee extends StatefulWidget {
  const ElogirMarquee({
    super.key,
    required this.child,
    this.velocity = 30.0,
    this.gap = 40.0,
    this.pauseDuration = const Duration(seconds: 2),
    this.startDelay = const Duration(seconds: 1),
  });

  final Widget child;

  /// Scroll speed in logical pixels per second.
  final double velocity;

  /// Gap between the end of the text and the start of the repeat.
  final double gap;

  /// How long to pause at each end before scrolling.
  final Duration pauseDuration;

  /// Initial delay before the first scroll.
  final Duration startDelay;

  @override
  State<ElogirMarquee> createState() => _ElogirMarqueeState();
}

class _ElogirMarqueeState extends State<ElogirMarquee>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  bool _needsScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _checkOverflow() {
    if (!mounted) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      _needsScroll = true;
      Future.delayed(widget.startDelay, () {
        if (mounted) _startScrollLoop();
      });
    }
  }

  Future<void> _startScrollLoop() async {
    while (mounted && _needsScroll) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll <= 0) break;

      final duration = Duration(
        milliseconds: (maxScroll / widget.velocity * 1000).round(),
      );

      await _scrollController.animateTo(
        maxScroll,
        duration: duration,
        curve: Curves.linear,
      );

      if (!mounted) break;
      await Future.delayed(widget.pauseDuration);
      if (!mounted) break;

      await _scrollController.animateTo(
        0,
        duration: duration,
        curve: Curves.linear,
      );

      if (!mounted) break;
      await Future.delayed(widget.pauseDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const _NoScrollbarBehavior(),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}

class _NoScrollbarBehavior extends ScrollBehavior {
  const _NoScrollbarBehavior();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
