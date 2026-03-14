import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class DataDisplaySection extends StatelessWidget {
  const DataDisplaySection({super.key});

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
