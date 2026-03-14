import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/theme_data.dart';
import '../interaction/elogir_pressable.dart';

/// Definition of a column in an [ElogirDataTable].
class ElogirDataColumn {
  const ElogirDataColumn({
    required this.label,
    this.sortable = false,
    this.numeric = false,
  });

  /// Column header widget (typically a [Text]).
  final Widget label;

  /// Whether tapping the header sorts by this column.
  final bool sortable;

  /// If true, cell content is right-aligned (for numbers, currency).
  final bool numeric;
}

/// A single row in an [ElogirDataTable].
class ElogirDataRow {
  const ElogirDataRow({
    required this.cells,
    this.selected = false,
    this.onSelectChanged,
  });

  /// One widget per column. Must match [ElogirDataTable.columns] length.
  final List<Widget> cells;

  /// Whether this row is currently selected (checkbox checked).
  final bool selected;

  /// Called when the row's selection checkbox is toggled.
  /// If null, the row does not show a checkbox.
  final ValueChanged<bool>? onSelectChanged;
}

/// A data table with sortable columns and optional row selection.
///
/// Soft Industrial style: thick-bordered container, warm neutral header
/// background, hover-highlighted rows, custom-drawn sort arrows and
/// checkboxes. No Material imports.
///
/// ```dart
/// ElogirDataTable(
///   columns: [
///     ElogirDataColumn(label: Text('Name'), sortable: true),
///     ElogirDataColumn(label: Text('Email')),
///     ElogirDataColumn(label: Text('Revenue'), numeric: true, sortable: true),
///   ],
///   rows: users.map((u) => ElogirDataRow(
///     cells: [Text(u.name), Text(u.email), Text(u.revenue)],
///     selected: selectedIds.contains(u.id),
///     onSelectChanged: (v) => toggleSelection(u.id, v),
///   )).toList(),
///   sortColumnIndex: _sortCol,
///   sortAscending: _ascending,
///   onSort: (col, asc) => setState(() { _sortCol = col; _ascending = asc; }),
/// )
/// ```
class ElogirDataTable extends StatelessWidget {
  const ElogirDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSort,
    this.showCheckboxColumn = false,
    this.onSelectAll,
  });

  /// Column definitions. Each row must have the same number of cells.
  final List<ElogirDataColumn> columns;

  /// Data rows.
  final List<ElogirDataRow> rows;

  /// Index of the currently sorted column, or null if unsorted.
  final int? sortColumnIndex;

  /// Whether the sorted column is ascending.
  final bool sortAscending;

  /// Called when a sortable column header is tapped.
  final void Function(int columnIndex, bool ascending)? onSort;

  /// Whether to show a checkbox column for row selection.
  final bool showCheckboxColumn;

  /// Called when the header select-all checkbox is toggled.
  final ValueChanged<bool>? onSelectAll;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    final allSelected = rows.isNotEmpty && rows.every((r) => r.selected);
    final someSelected = rows.any((r) => r.selected) && !allSelected;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.outline,
          width: theme.strokes.thick,
        ),
        borderRadius: theme.radii.md,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            (theme.radii.md.topLeft.x - theme.strokes.thick).clamp(0, double.infinity),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _HeaderRow(
            columns: columns,
            theme: theme,
            sortColumnIndex: sortColumnIndex,
            sortAscending: sortAscending,
            onSort: onSort,
            showCheckbox: showCheckboxColumn,
            allSelected: allSelected,
            indeterminate: someSelected,
            onSelectAll: onSelectAll,
          ),
          // Data rows
          for (int i = 0; i < rows.length; i++)
            _DataRowWidget(
              row: rows[i],
              columns: columns,
              theme: theme,
              showCheckbox: showCheckboxColumn,
              isLast: i == rows.length - 1,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Header Row ───────────────────────────────────────────────────

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.columns,
    required this.theme,
    required this.sortColumnIndex,
    required this.sortAscending,
    required this.onSort,
    required this.showCheckbox,
    required this.allSelected,
    required this.indeterminate,
    required this.onSelectAll,
  });

  final List<ElogirDataColumn> columns;
  final ElogirThemeData theme;
  final int? sortColumnIndex;
  final bool sortAscending;
  final void Function(int, bool)? onSort;
  final bool showCheckbox;
  final bool allSelected;
  final bool indeterminate;
  final ValueChanged<bool>? onSelectAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colors.surfaceContainer,
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.sm + 2,
      ),
      child: Row(
        children: [
          if (showCheckbox) ...[
            _MiniCheckbox(
              checked: allSelected,
              indeterminate: indeterminate,
              onChanged: (v) => onSelectAll?.call(v),
              theme: theme,
            ),
            SizedBox(width: theme.spacing.md),
          ],
          for (int i = 0; i < columns.length; i++) ...[
            if (i > 0) SizedBox(width: theme.spacing.sm),
            _HeaderCell(
              column: columns[i],
              isSorted: sortColumnIndex == i,
              ascending: sortAscending,
              theme: theme,
              onTap: columns[i].sortable
                  ? () {
                      final asc =
                          sortColumnIndex == i ? !sortAscending : true;
                      onSort?.call(i, asc);
                    }
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({
    required this.column,
    required this.isSorted,
    required this.ascending,
    required this.theme,
    required this.onTap,
  });

  final ElogirDataColumn column;
  final bool isSorted;
  final bool ascending;
  final ElogirThemeData theme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          column.numeric ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: DefaultTextStyle(
            style: theme.typography.labelLarge.copyWith(
              color: theme.colors.onSurface,
            ),
            child: column.label,
          ),
        ),
        if (isSorted) ...[
          SizedBox(width: theme.spacing.xs),
          CustomPaint(
            size: const Size(10, 10),
            painter: _SortArrowPainter(
              ascending: ascending,
              color: theme.colors.primary,
              strokeWidth: theme.strokes.thick,
            ),
          ),
        ],
      ],
    );

    return Expanded(
      child: onTap != null
          ? ElogirPressable(
              onPressed: onTap,
              pressScale: 1.0,
              child: content,
            )
          : content,
    );
  }
}

// ─── Data Row ─────────────────────────────────────────────────────

class _DataRowWidget extends StatefulWidget {
  const _DataRowWidget({
    required this.row,
    required this.columns,
    required this.theme,
    required this.showCheckbox,
    required this.isLast,
  });

  final ElogirDataRow row;
  final List<ElogirDataColumn> columns;
  final ElogirThemeData theme;
  final bool showCheckbox;
  final bool isLast;

  @override
  State<_DataRowWidget> createState() => _DataRowWidgetState();
}

class _DataRowWidgetState extends State<_DataRowWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final colors = theme.colors;
    final row = widget.row;

    return ElogirPressable(
      onPressed: row.onSelectChanged != null
          ? () => row.onSelectChanged!(!row.selected)
          : null,
      onHoverChanged: (v) => setState(() => _hovered = v),
      pressScale: 1.0,
      cursor: row.onSelectChanged != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: theme.durations.fast,
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: row.selected
              ? colors.primaryContainer
              : _hovered
                  ? Color.lerp(colors.surface, colors.surfaceContainer, 0.45)
                  : colors.surface,
          border: widget.isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: colors.outlineVariant,
                    width: theme.strokes.thin,
                  ),
                ),
        ),
        child: Row(
          children: [
            if (widget.showCheckbox) ...[
              _MiniCheckbox(
                checked: row.selected,
                onChanged: row.onSelectChanged != null
                    ? (v) => row.onSelectChanged!(v)
                    : null,
                theme: theme,
              ),
              SizedBox(width: theme.spacing.md),
            ],
            for (int i = 0; i < widget.columns.length; i++) ...[
              if (i > 0) SizedBox(width: theme.spacing.sm),
              Expanded(
                child: Align(
                  alignment: widget.columns[i].numeric
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: DefaultTextStyle(
                    style: theme.typography.bodyMedium.copyWith(
                      color: colors.onSurface,
                    ),
                    child: i < row.cells.length
                        ? row.cells[i]
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Mini Checkbox (inline for table rows) ────────────────────────

class _MiniCheckbox extends StatefulWidget {
  const _MiniCheckbox({
    required this.checked,
    this.indeterminate = false,
    required this.onChanged,
    required this.theme,
  });

  final bool checked;
  final bool indeterminate;
  final ValueChanged<bool>? onChanged;
  final ElogirThemeData theme;

  @override
  State<_MiniCheckbox> createState() => _MiniCheckboxState();
}

class _MiniCheckboxState extends State<_MiniCheckbox> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.theme.colors;
    final enabled = widget.onChanged != null;

    return ElogirPressable(
      enabled: enabled,
      onPressed: enabled
          ? () => widget.onChanged!(!widget.checked)
          : null,
      onHoverChanged: (v) => setState(() => _hovered = v),
      pressScale: 0.9,
      child: CustomPaint(
        size: const Size.square(18),
        painter: _TableCheckboxPainter(
          checked: widget.checked,
          indeterminate: widget.indeterminate,
          borderColor: enabled
              ? (_hovered ? colors.primary : colors.outline)
              : colors.disabled,
          fillColor: colors.primary,
          checkColor: colors.onPrimary,
          strokeWidth: widget.theme.strokes.thick,
        ),
      ),
    );
  }
}

// ─── Custom Painters ──────────────────────────────────────────────

class _TableCheckboxPainter extends CustomPainter {
  _TableCheckboxPainter({
    required this.checked,
    this.indeterminate = false,
    required this.borderColor,
    required this.fillColor,
    required this.checkColor,
    required this.strokeWidth,
  });

  final bool checked;
  final bool indeterminate;
  final Color borderColor;
  final Color fillColor;
  final Color checkColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final insetRect = rect.deflate(strokeWidth / 2);
    final rrect = RRect.fromRectAndRadius(insetRect, const Radius.circular(3));

    if (checked || indeterminate) {
      canvas.drawRRect(rrect, Paint()..color = fillColor);
    }

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = (checked || indeterminate) ? fillColor : borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    final markPaint = Paint()
      ..color = checkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (indeterminate) {
      // Horizontal dash
      canvas.drawLine(
        Offset(size.width * 0.25, size.height * 0.5),
        Offset(size.width * 0.75, size.height * 0.5),
        markPaint,
      );
    } else if (checked) {
      // Check mark
      final path = Path()
        ..moveTo(size.width * 0.2, size.height * 0.5)
        ..lineTo(size.width * 0.4, size.height * 0.72)
        ..lineTo(size.width * 0.8, size.height * 0.28);
      canvas.drawPath(path, markPaint);
    }
  }

  @override
  bool shouldRepaint(_TableCheckboxPainter old) =>
      checked != old.checked ||
      indeterminate != old.indeterminate ||
      borderColor != old.borderColor;
}

class _SortArrowPainter extends CustomPainter {
  _SortArrowPainter({
    required this.ascending,
    required this.color,
    required this.strokeWidth,
  });

  final bool ascending;
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
    if (ascending) {
      // Arrow pointing up
      path.moveTo(size.width * 0.2, size.height * 0.65);
      path.lineTo(size.width * 0.5, size.height * 0.25);
      path.lineTo(size.width * 0.8, size.height * 0.65);
    } else {
      // Arrow pointing down
      path.moveTo(size.width * 0.2, size.height * 0.35);
      path.lineTo(size.width * 0.5, size.height * 0.75);
      path.lineTo(size.width * 0.8, size.height * 0.35);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SortArrowPainter old) =>
      ascending != old.ascending || color != old.color;
}
