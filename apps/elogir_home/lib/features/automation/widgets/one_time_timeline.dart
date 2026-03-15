import 'dart:async';

import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/models/automation_trigger.dart';
import 'package:elogir_home/features/automation/widgets/automation_card.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Grouped timeline view for one-time automations, with date separator
/// headers and scroll-to-today.
class OneTimeTimeline extends StatefulWidget {
  const OneTimeTimeline({required this.automations, super.key});

  final List<Automation> automations;

  @override
  State<OneTimeTimeline> createState() => _OneTimeTimelineState();
}

class _OneTimeTimelineState extends State<OneTimeTimeline> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _todayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_scrollToToday());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollToToday() async {
    final keyContext = _todayKey.currentContext;
    if (keyContext != null) {
      await Scrollable.ensureVisible(
        keyContext,
        alignment: 0.1,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.automations.isEmpty) return const _EmptyState();

    final theme = ElogirTheme.of(context);
    final groups = _groupByDate(widget.automations);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(theme.spacing.md),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final entry = groups[index];
        final isToday = entry.date == today;
        final isPast = entry.date.isBefore(today);

        return Column(
          key: isToday ? _todayKey : null,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0) SizedBox(height: theme.spacing.md),
            Padding(
              padding: EdgeInsets.only(bottom: theme.spacing.sm),
              child: ElogirText(
                _formatDateHeader(entry.date, now),
                variant: ElogirTextVariant.labelLarge,
                style: TextStyle(
                  color: isPast
                      ? theme.colors.onSurfaceVariant
                      : theme.colors.primary,
                ),
              ),
            ),
            ...entry.automations.map(
              (automation) => Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.sm),
                child: Opacity(
                  opacity: isPast && !automation.isEnabled ? 0.5 : 1.0,
                  child: AutomationCard(automation: automation),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<_DateGroup> _groupByDate(List<Automation> automations) {
    // Sort by scheduled time.
    final sorted = List.of(automations)..sort((a, b) {
        final aTime = (a.trigger as OneTimeTrigger).scheduledAt;
        final bTime = (b.trigger as OneTimeTrigger).scheduledAt;
        return aTime.compareTo(bTime);
      });

    final groups = <DateTime, List<Automation>>{};
    for (final automation in sorted) {
      final scheduledAt = (automation.trigger as OneTimeTrigger).scheduledAt;
      final dateKey = DateTime(
        scheduledAt.year,
        scheduledAt.month,
        scheduledAt.day,
      );
      (groups[dateKey] ??= []).add(automation);
    }

    return groups.entries
        .map((e) => _DateGroup(date: e.key, automations: e.value))
        .toList();
  }

  String _formatDateHeader(DateTime date, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    if (date == today) return 'Today';
    if (date == tomorrow) return 'Tomorrow';
    return DateFormat('EEE MMM d').format(date);
  }
}

class _DateGroup {
  const _DateGroup({required this.date, required this.automations});
  final DateTime date;
  final List<Automation> automations;
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.calendarDay,
            size: 48,
            color: theme.colors.onSurfaceVariant,
          ),
          SizedBox(height: theme.spacing.md),
          const ElogirText(
            'No scheduled automations',
            variant: ElogirTextVariant.titleMedium,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirText(
            'Tap + to schedule one',
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.lg),
          ElogirButton(
            onPressed: () => context.go('/add-automation'),
            child: const Text('Add Automation'),
          ),
        ],
      ),
    );
  }
}
