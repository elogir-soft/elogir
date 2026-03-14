import 'package:flutter/widgets.dart';

/// A list that animates items in with staggered fade + slide, and supports
/// automatic insertion and removal animations based on item diffing.
class ElogirAnimatedList<T> extends StatefulWidget {
  const ElogirAnimatedList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.itemKey,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.animationDuration = const Duration(milliseconds: 300),
    this.removeDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
    this.slideOffset = 20.0,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.padding,
    this.animateInitial = false,
  });

  /// The data items to display.
  final List<T> items;

  /// Builds a widget for the given item.
  final Widget Function(
    BuildContext context,
    T item,
    Animation<double> animation,
  ) itemBuilder;

  /// Returns a unique key for the item to track it during diffing.
  final dynamic Function(T item) itemKey;

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

  /// Optional padding around the list.
  final EdgeInsetsGeometry? padding;

  /// Whether items should animate in when the list is first built.
  final bool animateInitial;

  @override
  State<ElogirAnimatedList<T>> createState() => _ElogirAnimatedListState<T>();
}

class _ElogirAnimatedListState<T> extends State<ElogirAnimatedList<T>>
    with TickerProviderStateMixin {
  final List<_Entry<T>> _entries = [];

  @override
  void initState() {
    super.initState();
    _syncItems();
    if (widget.animateInitial) {
      _staggerInitial();
    } else {
      for (final entry in _entries) {
        entry.controller.value = 1.0;
      }
    }
  }

  @override
  void didUpdateWidget(ElogirAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncItems();
  }

  void _syncItems() {
    final newItems = widget.items;
    final newKeys = newItems.map(widget.itemKey).toList();

    // 1. Remove items that are no longer present
    for (int i = _entries.length - 1; i >= 0; i--) {
      final entry = _entries[i];
      if (entry.removing) continue;

      final key = widget.itemKey(entry.item);
      if (!newKeys.contains(key)) {
        _removeItem(i);
      }
    }

    // 2. Insert items that are new
    final currentKeys =
        _entries.where((e) => !e.removing).map((e) => widget.itemKey(e.item)).toList();

    for (int i = 0; i < newItems.length; i++) {
      final item = newItems[i];
      final key = widget.itemKey(item);

      if (!currentKeys.contains(key)) {
        _insertItem(i, item);
        currentKeys.insert(i, key);
      } else {
        // Update existing entry item data (in case it changed but key is same)
        final entryIndex = _activeIndexToEntryIndex(i);
        if (entryIndex < _entries.length) {
          _entries[entryIndex].item = item;
        }
      }
    }
  }

  void _insertItem(int index, T item) {
    final controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    final entry = _Entry(
      item: item,
      controller: controller,
      curve: widget.curve,
    );

    setState(() {
      _entries.insert(_activeIndexToEntryIndex(index), entry);
    });

    controller.forward();
  }

  void _removeItem(int index) {
    final entryIndex = _activeIndexToEntryIndex(index);
    final entry = _entries[entryIndex];

    setState(() {
      entry.removing = true;
    });

    entry.controller.duration = widget.removeDuration;
    entry.controller.reverse().then((_) {
      if (!mounted) return;
      setState(() {
        _entries.remove(entry);
        entry.dispose();
      });
    });
  }

  Future<void> _staggerInitial() async {
    for (int i = 0; i < _entries.length; i++) {
      if (!mounted) return;
      // Only stagger items that haven't started yet
      if (_entries[i].controller.status == AnimationStatus.dismissed) {
        if (i > 0) await Future.delayed(widget.staggerDelay);
        if (!mounted) return;
        _entries[i].controller.forward();
      }
    }
  }

  int _activeIndexToEntryIndex(int activeIndex) {
    int active = 0;
    for (int i = 0; i < _entries.length; i++) {
      if (!_entries[i].removing) {
        if (active == activeIndex) return i;
        active++;
      }
    }
    return _entries.length;
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

    for (final entry in _entries) {
      children.add(
        SizeTransition(
          sizeFactor: entry.controller,
          child: FadeTransition(
            opacity: entry.curved,
            child: AnimatedBuilder(
              animation: entry.curved,
              builder: (ctx, ch) => Transform.translate(
                offset: Offset(0, widget.slideOffset * (1 - entry.curved.value)),
                child: ch,
              ),
              child: widget.itemBuilder(context, entry.item, entry.curved),
            ),
          ),
        ),
      );
    }

    Widget result = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: children,
    );

    if (widget.padding != null) {
      result = Padding(padding: widget.padding!, child: result);
    }

    return result;
  }
}

class _Entry<T> {
  _Entry({
    required this.item,
    required this.controller,
    required Curve curve,
  }) : curved = CurvedAnimation(parent: controller, curve: curve);

  T item;
  final AnimationController controller;
  final CurvedAnimation curved;
  bool removing = false;

  void dispose() {
    curved.dispose();
    controller.dispose();
  }
}
