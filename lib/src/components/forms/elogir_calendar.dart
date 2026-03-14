import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';
import '../interaction/elogir_pressable.dart';

/// Whether the calendar selects a single date, a range, or multiple dates.
enum ElogirDateSelectionMode { single, range, multiple }

/// A standalone calendar widget that can be embedded inline, placed in a
/// dialog, or used inside any container.
///
/// ```dart
/// // Inline single-select
/// ElogirCalendar(
///   value: _date,
///   onChanged: (d) => setState(() => _date = d),
/// )
///
/// // Range
/// ElogirCalendar(
///   selectionMode: ElogirDateSelectionMode.range,
///   rangeStart: _start,
///   rangeEnd: _end,
///   onRangeChanged: (s, e) => setState(() { _start = s; _end = e; }),
/// )
///
/// // Multiple
/// ElogirCalendar(
///   selectionMode: ElogirDateSelectionMode.multiple,
///   selectedDates: _dates,
///   onMultiChanged: (d) => setState(() => _dates = d),
/// )
/// ```
class ElogirCalendar extends StatefulWidget {
  const ElogirCalendar({
    super.key,
    // Single mode
    this.value,
    this.onChanged,
    // Range mode
    this.rangeStart,
    this.rangeEnd,
    this.onRangeChanged,
    // Multi mode
    this.selectedDates,
    this.onMultiChanged,
    // Mode
    this.selectionMode = ElogirDateSelectionMode.single,
    // Bounds
    this.firstDate,
    this.lastDate,
    // Display
    this.width,
  });

  final DateTime? value;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final void Function(DateTime start, DateTime end)? onRangeChanged;
  final Set<DateTime>? selectedDates;
  final ValueChanged<Set<DateTime>>? onMultiChanged;
  final ElogirDateSelectionMode selectionMode;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// Width of the calendar. Defaults to 296.
  final double? width;

  @override
  State<ElogirCalendar> createState() => _ElogirCalendarState();
}

class _ElogirCalendarState extends State<ElogirCalendar> {
  late int _year;
  late int _month;
  _ViewMode _view = _ViewMode.days;
  DateTime? _pendingRangeStart;

  late DateTime _firstDate;
  late DateTime _lastDate;

  @override
  void initState() {
    super.initState();
    _updateBounds();
    final initial =
        widget.value ?? widget.rangeStart ?? DateTime.now();
    _year = initial.year;
    _month = initial.month;

    if (widget.selectionMode == ElogirDateSelectionMode.range) {
      if (widget.rangeStart != null && widget.rangeEnd == null) {
        _pendingRangeStart = widget.rangeStart;
      }
    }
  }

  @override
  void didUpdateWidget(ElogirCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateBounds();
  }

  void _updateBounds() {
    _firstDate = widget.firstDate ?? DateTime(DateTime.now().year - 100);
    _lastDate =
        widget.lastDate ?? DateTime(DateTime.now().year + 100, 12, 31);
  }

  void _onDayTapped(DateTime date) {
    switch (widget.selectionMode) {
      case ElogirDateSelectionMode.single:
        widget.onChanged?.call(date);

      case ElogirDateSelectionMode.range:
        if (_pendingRangeStart == null) {
          setState(() => _pendingRangeStart = date);
        } else {
          DateTime start = _pendingRangeStart!;
          DateTime end = date;
          if (end.isBefore(start)) {
            final tmp = start;
            start = end;
            end = tmp;
          }
          _pendingRangeStart = null;
          widget.onRangeChanged?.call(start, end);
        }

      case ElogirDateSelectionMode.multiple:
        final dates = Set<DateTime>.from(widget.selectedDates ?? {});
        final existing = dates.where((d) => _sameDay(d, date)).toList();
        if (existing.isNotEmpty) {
          dates.removeAll(existing);
        } else {
          dates.add(DateTime(date.year, date.month, date.day));
        }
        widget.onMultiChanged?.call(dates);
    }
  }

  void _previousMonth() {
    setState(() {
      _month--;
      if (_month < 1) {
        _month = 12;
        _year--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      _month++;
      if (_month > 12) {
        _month = 1;
        _year++;
      }
    });
  }

  bool _canGoPrevious() {
    final prev = _month == 1
        ? DateTime(_year - 1, 12)
        : DateTime(_year, _month - 1);
    return !prev
        .isBefore(DateTime(_firstDate.year, _firstDate.month));
  }

  bool _canGoNext() {
    final next = _month == 12
        ? DateTime(_year + 1, 1)
        : DateTime(_year, _month + 1);
    return !next
        .isAfter(DateTime(_lastDate.year, _lastDate.month));
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return Container(
      width: widget.width ?? 296,
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: theme.radii.md,
        border: Border.all(
          color: colors.outline,
          width: theme.strokes.thick,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(theme),
          SizedBox(height: theme.spacing.sm),
          if (_view == _ViewMode.days) ...[
            _DayOfWeekHeaders(theme: theme),
            SizedBox(height: theme.spacing.xs),
            _MonthGrid(
              year: _year,
              month: _month,
              selectedDate: widget.value,
              rangeStart:
                  widget.selectionMode == ElogirDateSelectionMode.range
                      ? (_pendingRangeStart ?? widget.rangeStart)
                      : null,
              rangeEnd:
                  widget.selectionMode == ElogirDateSelectionMode.range
                      ? widget.rangeEnd
                      : null,
              selectedDates:
                  widget.selectionMode == ElogirDateSelectionMode.multiple
                      ? (widget.selectedDates ?? {})
                      : null,
              firstDate: _firstDate,
              lastDate: _lastDate,
              onDateSelected: _onDayTapped,
              theme: theme,
            ),
          ] else if (_view == _ViewMode.months)
            _MonthPicker(
              year: _year,
              selectedMonth: _month,
              firstDate: _firstDate,
              lastDate: _lastDate,
              theme: theme,
              onMonthSelected: (m) {
                setState(() {
                  _month = m;
                  _view = _ViewMode.days;
                });
              },
            )
          else
            _YearPicker(
              selectedYear: _year,
              firstDate: _firstDate,
              lastDate: _lastDate,
              theme: theme,
              onYearSelected: (y) {
                setState(() {
                  _year = y;
                  _view = _ViewMode.months;
                });
              },
            ),
          // Footer
          if (_view == _ViewMode.days) ...[
            if (widget.selectionMode == ElogirDateSelectionMode.range &&
                _pendingRangeStart != null)
              Padding(
                padding: EdgeInsets.only(top: theme.spacing.sm),
                child: Text(
                  'Select end date',
                  style: theme.typography.caption.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            if (widget.selectionMode ==
                    ElogirDateSelectionMode.multiple &&
                (widget.selectedDates ?? {}).isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: theme.spacing.sm),
                child: _MultiFooter(
                  count: (widget.selectedDates ?? {}).length,
                  onClear: () =>
                      widget.onMultiChanged?.call(const {}),
                  theme: theme,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(ElogirThemeData theme) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];

    if (_view == _ViewMode.days) {
      return Row(
        children: [
          _NavArrow(
            direction: _ArrowDir.left,
            enabled: _canGoPrevious(),
            onPressed: _canGoPrevious() ? _previousMonth : null,
            theme: theme,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _HoverLabel(
                  text: monthNames[_month - 1],
                  onPressed: () =>
                      setState(() => _view = _ViewMode.months),
                  theme: theme,
                ),
                SizedBox(width: theme.spacing.xs),
                _HoverLabel(
                  text: '$_year',
                  onPressed: () =>
                      setState(() => _view = _ViewMode.years),
                  theme: theme,
                ),
              ],
            ),
          ),
          _NavArrow(
            direction: _ArrowDir.right,
            enabled: _canGoNext(),
            onPressed: _canGoNext() ? _nextMonth : null,
            theme: theme,
          ),
        ],
      );
    }

    if (_view == _ViewMode.months) {
      return Row(
        children: [
          _NavArrow(
            direction: _ArrowDir.left,
            enabled: _year > _firstDate.year,
            onPressed: _year > _firstDate.year
                ? () => setState(() => _year--)
                : null,
            theme: theme,
          ),
          Expanded(
            child: Center(
              child: _HoverLabel(
                text: '$_year',
                onPressed: () =>
                    setState(() => _view = _ViewMode.years),
                theme: theme,
              ),
            ),
          ),
          _NavArrow(
            direction: _ArrowDir.right,
            enabled: _year < _lastDate.year,
            onPressed: _year < _lastDate.year
                ? () => setState(() => _year++)
                : null,
            theme: theme,
          ),
        ],
      );
    }

    // Years view header
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Select Year',
          style: theme.typography.titleSmall.copyWith(
            color: theme.colors.onSurface,
          ),
        ),
      ],
    );
  }
}

// ─── Internal view mode ──────────────────────────────────────────

enum _ViewMode { days, months, years }

// ─── Hover Label (month/year in header) ───────────────────────────

class _HoverLabel extends StatefulWidget {
  const _HoverLabel({
    required this.text,
    required this.onPressed,
    required this.theme,
  });

  final String text;
  final VoidCallback onPressed;
  final ElogirThemeData theme;

  @override
  State<_HoverLabel> createState() => _HoverLabelState();
}

class _HoverLabelState extends State<_HoverLabel> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.theme.spacing.xs + 2,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: _hovered
                ? colors.surfaceContainer
                : const Color(0x00000000),
            borderRadius: widget.theme.radii.sm,
          ),
          child: Text(
            widget.text,
            style: widget.theme.typography.titleSmall.copyWith(
              color: colors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Multi-select Footer ──────────────────────────────────────────

class _MultiFooter extends StatefulWidget {
  const _MultiFooter({
    required this.count,
    required this.onClear,
    required this.theme,
  });

  final int count;
  final VoidCallback onClear;
  final ElogirThemeData theme;

  @override
  State<_MultiFooter> createState() => _MultiFooterState();
}

class _MultiFooterState extends State<_MultiFooter> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    return Row(
      children: [
        Text(
          '${widget.count} selected',
          style: widget.theme.typography.labelSmall.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onClear,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.theme.spacing.xs + 2,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: _hovered
                    ? colors.surfaceContainer
                    : const Color(0x00000000),
                borderRadius: widget.theme.radii.sm,
              ),
              child: Text(
                'Clear',
                style: widget.theme.typography.labelSmall.copyWith(
                  color: _hovered ? colors.error : colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Day-of-week Headers ──────────────────────────────────────────

class _DayOfWeekHeaders extends StatelessWidget {
  const _DayOfWeekHeaders({required this.theme});
  final ElogirThemeData theme;

  @override
  Widget build(BuildContext context) {
    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return Row(
      children: [
        for (final day in days)
          Expanded(
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: theme.typography.caption.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Month Grid (day cells) ───────────────────────────────────────

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.year,
    required this.month,
    required this.selectedDate,
    required this.rangeStart,
    required this.rangeEnd,
    required this.selectedDates,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    required this.theme,
  });

  final int year;
  final int month;
  final DateTime? selectedDate;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final Set<DateTime>? selectedDates;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final ElogirThemeData theme;

  @override
  Widget build(BuildContext context) {
    final firstOfMonth = DateTime(year, month, 1);
    final startOffset = firstOfMonth.weekday - 1;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final today = DateTime.now();

    final rows = <Widget>[];

    for (int row = 0; row < 6; row++) {
      final cells = <Widget>[];
      bool rowHasDays = false;

      for (int col = 0; col < 7; col++) {
        final dayNumber = row * 7 + col - startOffset + 1;

        if (dayNumber < 1 || dayNumber > daysInMonth) {
          cells.add(const Expanded(child: SizedBox(height: 34)));
        } else {
          rowHasDays = true;
          final date = DateTime(year, month, dayNumber);
          final isSelected = selectedDate != null &&
              _sameDay(selectedDate!, date);
          final isRangeStart =
              rangeStart != null && _sameDay(rangeStart!, date);
          final isRangeEnd =
              rangeEnd != null && _sameDay(rangeEnd!, date);
          final isInRange = rangeStart != null &&
              rangeEnd != null &&
              date.isAfter(rangeStart!) &&
              date.isBefore(rangeEnd!);
          final isMultiSelected = selectedDates != null &&
              selectedDates!.any((d) => _sameDay(d, date));
          final isToday = _sameDay(today, date);
          final isEnabled =
              !date.isBefore(firstDate) && !date.isAfter(lastDate);

          cells.add(
            Expanded(
              child: _DayCell(
                day: dayNumber,
                isSelected: isSelected ||
                    isRangeStart ||
                    isRangeEnd ||
                    isMultiSelected,
                isInRange: isInRange,
                isToday: isToday,
                isEnabled: isEnabled,
                onTap: isEnabled ? () => onDateSelected(date) : null,
                theme: theme,
              ),
            ),
          );
        }
      }

      if (!rowHasDays) break;
      rows.add(Row(children: cells));
    }

    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

// ─── Day Cell ─────────────────────────────────────────────────────

class _DayCell extends StatefulWidget {
  const _DayCell({
    required this.day,
    required this.isSelected,
    required this.isInRange,
    required this.isToday,
    required this.isEnabled,
    required this.onTap,
    required this.theme,
  });

  final int day;
  final bool isSelected;
  final bool isInRange;
  final bool isToday;
  final bool isEnabled;
  final VoidCallback? onTap;
  final ElogirThemeData theme;

  @override
  State<_DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<_DayCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    Color bgColor;
    Color textColor;
    Border? border;

    if (widget.isSelected) {
      bgColor = colors.primary;
      textColor = colors.onPrimary;
    } else if (widget.isInRange) {
      bgColor = colors.primaryContainer;
      textColor = colors.onPrimaryContainer;
    } else if (_hovered && widget.isEnabled) {
      bgColor = colors.surfaceContainer;
      textColor = colors.onSurface;
    } else {
      bgColor = const Color(0x00000000);
      textColor = widget.isEnabled ? colors.onSurface : colors.onDisabled;
    }

    if (widget.isToday && !widget.isSelected) {
      border = Border.all(
        color: colors.primary,
        width: widget.theme.strokes.medium,
      );
    }

    return ElogirPressable(
      enabled: widget.isEnabled,
      onPressed: widget.onTap,
      onHoverChanged: (v) => setState(() => _hovered = v),
      pressScale: 0.92,
      child: Container(
        height: 34,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: widget.theme.radii.sm,
          border: border,
        ),
        alignment: Alignment.center,
        child: Text(
          '${widget.day}',
          style: widget.theme.typography.bodySmall.copyWith(
            color: textColor,
            fontWeight: widget.isSelected || widget.isToday
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// ─── Month Picker ─────────────────────────────────────────────────

class _MonthPicker extends StatelessWidget {
  const _MonthPicker({
    required this.year,
    required this.selectedMonth,
    required this.firstDate,
    required this.lastDate,
    required this.theme,
    required this.onMonthSelected,
  });

  final int year;
  final int selectedMonth;
  final DateTime firstDate;
  final DateTime lastDate;
  final ElogirThemeData theme;
  final ValueChanged<int> onMonthSelected;

  @override
  Widget build(BuildContext context) {
    const shortNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    final rows = <Widget>[];
    for (int row = 0; row < 4; row++) {
      final cells = <Widget>[];
      for (int col = 0; col < 3; col++) {
        final m = row * 3 + col + 1;
        final monthDate = DateTime(year, m);
        final isEnabled = !monthDate.isBefore(
                DateTime(firstDate.year, firstDate.month)) &&
            !monthDate.isAfter(DateTime(lastDate.year, lastDate.month));
        final isSelected = m == selectedMonth;

        cells.add(
          Expanded(
            child: _GridCell(
              label: shortNames[m - 1],
              isSelected: isSelected,
              isEnabled: isEnabled,
              onTap: isEnabled ? () => onMonthSelected(m) : null,
              theme: theme,
            ),
          ),
        );
      }
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.xs),
          child: Row(children: cells),
        ),
      );
    }

    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }
}

// ─── Year Picker ──────────────────────────────────────────────────

class _YearPicker extends StatelessWidget {
  const _YearPicker({
    required this.selectedYear,
    required this.firstDate,
    required this.lastDate,
    required this.theme,
    required this.onYearSelected,
  });

  final int selectedYear;
  final DateTime firstDate;
  final DateTime lastDate;
  final ElogirThemeData theme;
  final ValueChanged<int> onYearSelected;

  @override
  Widget build(BuildContext context) {
    final startYear = selectedYear - 5;

    final rows = <Widget>[];
    for (int row = 0; row < 4; row++) {
      final cells = <Widget>[];
      for (int col = 0; col < 3; col++) {
        final y = startYear + row * 3 + col;
        final isEnabled = y >= firstDate.year && y <= lastDate.year;
        final isSelected = y == selectedYear;

        cells.add(
          Expanded(
            child: _GridCell(
              label: '$y',
              isSelected: isSelected,
              isEnabled: isEnabled,
              onTap: isEnabled ? () => onYearSelected(y) : null,
              theme: theme,
            ),
          ),
        );
      }
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.xs),
          child: Row(children: cells),
        ),
      );
    }

    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }
}

// ─── Shared Grid Cell (month/year pickers) ────────────────────────

class _GridCell extends StatefulWidget {
  const _GridCell({
    required this.label,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
    required this.theme,
  });

  final String label;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback? onTap;
  final ElogirThemeData theme;

  @override
  State<_GridCell> createState() => _GridCellState();
}

class _GridCellState extends State<_GridCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;

    Color bgColor;
    Color textColor;

    if (widget.isSelected) {
      bgColor = colors.primary;
      textColor = colors.onPrimary;
    } else if (_hovered && widget.isEnabled) {
      bgColor = colors.surfaceContainer;
      textColor = colors.onSurface;
    } else {
      bgColor = const Color(0x00000000);
      textColor = widget.isEnabled ? colors.onSurface : colors.onDisabled;
    }

    return ElogirPressable(
      enabled: widget.isEnabled,
      onPressed: widget.onTap,
      onHoverChanged: (v) => setState(() => _hovered = v),
      pressScale: 0.95,
      child: Container(
        height: 40,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: widget.theme.radii.sm,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.label,
          style: widget.theme.typography.bodySmall.copyWith(
            color: textColor,
            fontWeight:
                widget.isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// ─── Navigation Arrow ─────────────────────────────────────────────

enum _ArrowDir { left, right }

class _NavArrow extends StatelessWidget {
  const _NavArrow({
    required this.direction,
    required this.enabled,
    required this.onPressed,
    required this.theme,
  });

  final _ArrowDir direction;
  final bool enabled;
  final VoidCallback? onPressed;
  final ElogirThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ElogirPressable(
      enabled: enabled,
      onPressed: onPressed,
      pressScale: 0.9,
      child: SizedBox(
        width: 28,
        height: 28,
        child: CustomPaint(
          painter: _ArrowPainter(
            direction: direction,
            color: enabled
                ? theme.colors.onSurfaceVariant
                : theme.colors.onDisabled,
            strokeWidth: theme.strokes.thick,
          ),
        ),
      ),
    );
  }
}

// ─── Custom Painters ──────────────────────────────────────────────

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.direction,
    required this.color,
    required this.strokeWidth,
  });

  final _ArrowDir direction;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    if (direction == _ArrowDir.left) {
      path.moveTo(size.width * 0.6, size.height * 0.25);
      path.lineTo(size.width * 0.35, size.height * 0.5);
      path.lineTo(size.width * 0.6, size.height * 0.75);
    } else {
      path.moveTo(size.width * 0.4, size.height * 0.25);
      path.lineTo(size.width * 0.65, size.height * 0.5);
      path.lineTo(size.width * 0.4, size.height * 0.75);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter old) =>
      direction != old.direction || color != old.color;
}
