import 'package:flutter/widgets.dart';

/// A list that animates items in with staggered fade + slide, and supports
/// programmatic insertion and removal with smooth transitions.
///
/// Use a [GlobalKey] to access [ElogirAnimatedListState] for dynamic updates:
///
/// ```dart
/// final _listKey = GlobalKey<ElogirAnimatedListState>();
///
/// ElogirAnimatedList(
///   key: _listKey,
///   initialItemCount: items.length,
///   itemBuilder: (context, index, animation) {
///     return MyCard(item: items[index]);
///   },
/// )
///
/// // Insert:
/// items.insert(0, newItem);
/// _listKey.currentState!.insertItem(0);
///
/// // Remove:
/// final removed = items.removeAt(index);
/// _listKey.currentState!.removeItem(
///   index,
///   (context, animation) => MyCard(item: removed),
/// );
/// ```
class ElogirAnimatedList extends StatefulWidget {
  const ElogirAnimatedList({
    super.key,
    required this.itemBuilder,
    this.initialItemCount = 0,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.animationDuration = const Duration(milliseconds: 300),
    this.removeDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
    this.slideOffset = 20.0,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  /// Builds a widget for the item at [index].
  ///
  /// The [animation] goes from 0.0 (entering) to 1.0 (fully visible).
  /// You don't need to animate the child yourself — the list wraps it
  /// in fade + slide + size transitions automatically.
  final Widget Function(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) itemBuilder;

  /// Number of items when the list first appears.
  /// These items animate in with a staggered delay.
  final int initialItemCount;

  /// Delay between each initial item's stagger animation.
  final Duration staggerDelay;

  /// Duration of each item's enter animation.
  final Duration animationDuration;

  /// Duration of each item's exit animation.
  final Duration removeDuration;

  /// Curve for enter/exit animations.
  final Curve curve;

  /// Vertical pixel offset items slide up from when entering.
  final double slideOffset;

  /// Cross axis alignment of the internal column.
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<ElogirAnimatedList> createState() => ElogirAnimatedListState();
}

class ElogirAnimatedListState extends State<ElogirAnimatedList>
    with TickerProviderStateMixin {
  final List<_Entry> _entries = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.initialItemCount; i++) {
      _entries.add(_Entry(
        controller: AnimationController(
          duration: widget.animationDuration,
          vsync: this,
        ),
        curve: widget.curve,
      ));
    }
    _staggerInitial();
  }

  Future<void> _staggerInitial() async {
    for (int i = 0; i < _entries.length; i++) {
      if (!mounted) return;
      if (i > 0) await Future.delayed(widget.staggerDelay);
      if (!mounted) return;
      _entries[i].controller.forward();
    }
  }

  /// Inserts an item at [index] with an enter animation.
  ///
  /// Call this **after** adding the item to your data source.
  void insertItem(int index, {Duration? duration}) {
    assert(index >= 0 && index <= _activeCount);
    final controller = AnimationController(
      duration: duration ?? widget.animationDuration,
      vsync: this,
    );
    setState(() {
      _entries.insert(
        _activeIndexToEntryIndex(index),
        _Entry(controller: controller, curve: widget.curve),
      );
    });
    controller.forward();
  }

  /// Removes the item at [index] with an exit animation.
  ///
  /// [removedItemBuilder] builds the widget shown during the exit animation.
  /// Call this **after** removing the item from your data source.
  void removeItem(
    int index,
    Widget Function(BuildContext context, Animation<double> animation)
        removedItemBuilder, {
    Duration? duration,
  }) {
    assert(index >= 0 && index < _activeCount);
    final entryIndex = _activeIndexToEntryIndex(index);
    final entry = _entries[entryIndex];
    entry.removing = true;
    entry.removedItemBuilder = removedItemBuilder;
    entry.controller.duration = duration ?? widget.removeDuration;
    setState(() {});

    entry.controller.reverse().then((_) {
      if (!mounted) return;
      setState(() {
        _entries.remove(entry);
        entry.dispose();
      });
    });
  }

  int get _activeCount => _entries.where((e) => !e.removing).length;

  /// Maps an active item index to the position in _entries (which may
  /// contain removing entries interspersed).
  int _activeIndexToEntryIndex(int activeIndex) {
    int active = 0;
    for (int i = 0; i < _entries.length; i++) {
      if (!_entries[i].removing) {
        if (active == activeIndex) return i;
        active++;
      }
    }
    return _entries.length; // append position
  }

  @override
  void dispose() {
    for (final e in _entries) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    int activeIndex = 0;

    for (final entry in _entries) {
      Widget child;
      if (entry.removing && entry.removedItemBuilder != null) {
        child = entry.removedItemBuilder!(context, entry.controller);
      } else {
        child = widget.itemBuilder(context, activeIndex, entry.controller);
        activeIndex++;
      }

      children.add(
        SizeTransition(
          sizeFactor: entry.controller, // linear for smooth, even collapse
          child: FadeTransition(
            opacity: entry.curved,
            child: AnimatedBuilder(
              animation: entry.curved,
              builder: (ctx, ch) => Transform.translate(
                offset: Offset(0, widget.slideOffset * (1 - entry.curved.value)),
                child: ch,
              ),
              child: child,
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: children,
    );
  }
}

class _Entry {
  _Entry({required this.controller, required Curve curve})
      : curved = CurvedAnimation(parent: controller, curve: curve);

  final AnimationController controller;
  final CurvedAnimation curved;
  bool removing = false;
  Widget Function(BuildContext, Animation<double>)? removedItemBuilder;

  void dispose() {
    curved.dispose();
    controller.dispose();
  }
}
