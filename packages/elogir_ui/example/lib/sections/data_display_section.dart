import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class DataDisplaySection extends StatefulWidget {
  const DataDisplaySection({super.key});

  @override
  State<DataDisplaySection> createState() => _DataDisplaySectionState();
}

class _DataDisplaySectionState extends State<DataDisplaySection> {
  int? _sortColumn;
  bool _sortAscending = true;
  final Set<int> _selectedRows = {};

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Data Display')),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElogirAvatar(initials: 'AB', size: ElogirAvatarSize.sm),
            ElogirAvatar(
              initials: 'CD',
              size: ElogirAvatarSize.md,
              showStatus: true,
              isOnline: true,
            ),
            ElogirAvatar(initials: 'EF', size: ElogirAvatarSize.lg),
            ElogirBadge(
              count: 5,
              child: ElogirAvatar(initials: 'GH', size: ElogirAvatarSize.md),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: [
            ElogirTag(label: 'Default'),
            ElogirTag(label: 'Primary', variant: ElogirTagVariant.primary),
            ElogirTag(
              label: 'Success',
              variant: ElogirTagVariant.success,
              selected: true,
            ),
            ElogirTag(label: 'Warning', variant: ElogirTagVariant.warning),
            ElogirTag(
              label: 'Removable',
              variant: ElogirTagVariant.error,
              onRemoved: () {},
            ),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Stat Cards')),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.md,
          children: const [
            ElogirStatCard(
              value: '1,234',
              label: 'Active Users',
              trend: '+12.5%',
              trendDirection: ElogirTrendDirection.up,
              width: 180,
            ),
            ElogirStatCard(
              value: '98.2',
              label: 'Uptime',
              suffix: '%',
              trend: '-0.3%',
              trendDirection: ElogirTrendDirection.down,
              width: 180,
            ),
            ElogirStatCard(
              value: '42',
              label: 'Response Time',
              suffix: 'ms',
              width: 180,
            ),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Data Table')),
        SizedBox(height: theme.spacing.md),
        ElogirDataTable(
          columns: const [
            ElogirDataColumn(label: Text('Name'), sortable: true),
            ElogirDataColumn(label: Text('Role')),
            ElogirDataColumn(
                label: Text('Revenue'), numeric: true, sortable: true),
          ],
          rows: [
            for (final entry in [
              ('Alice Chen', 'Engineer', '\$12,400', 0),
              ('Bob Martinez', 'Designer', '\$9,800', 1),
              ('Carol Kim', 'PM', '\$15,200', 2),
              ('Dan Okafor', 'Engineer', '\$11,600', 3),
            ])
              ElogirDataRow(
                cells: [Text(entry.$1), Text(entry.$2), Text(entry.$3)],
                selected: _selectedRows.contains(entry.$4),
                onSelectChanged: (v) {
                  setState(() {
                    if (v) {
                      _selectedRows.add(entry.$4);
                    } else {
                      _selectedRows.remove(entry.$4);
                    }
                  });
                },
              ),
          ],
          showCheckboxColumn: true,
          sortColumnIndex: _sortColumn,
          sortAscending: _sortAscending,
          onSort: (col, asc) => setState(() {
            _sortColumn = col;
            _sortAscending = asc;
          }),
          onSelectAll: (v) => setState(() {
            if (v) {
              _selectedRows.addAll([0, 1, 2, 3]);
            } else {
              _selectedRows.clear();
            }
          }),
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Breadcrumb')),
        SizedBox(height: theme.spacing.md),
        ElogirBreadcrumb(
          items: [
            ElogirBreadcrumbItem(label: 'Home', onPressed: () {}),
            ElogirBreadcrumbItem(label: 'Components', onPressed: () {}),
            ElogirBreadcrumbItem(label: 'Breadcrumb'),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Timeline')),
        SizedBox(height: theme.spacing.md),
        ElogirTimeline(
          items: [
            ElogirTimelineItem(
              title: const Text('Project started'),
              subtitle: const Text('March 1, 2026'),
              content: const Text('Initial commit and project setup.'),
            ),
            ElogirTimelineItem(
              title: const Text('Theme system'),
              subtitle: const Text('March 5, 2026'),
              content: const Text('Color palette, typography, spacing tokens.'),
            ),
            ElogirTimelineItem(
              title: const Text('Core widgets'),
              subtitle: const Text('March 10, 2026'),
            ),
            ElogirTimelineItem(
              title: const Text('Advanced widgets'),
              subtitle: const Text('March 14, 2026'),
              content: const Text('Drawer, bottom sheet, popover, etc.'),
            ),
          ],
        ),
      ],
    );
  }
}
