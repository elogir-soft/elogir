import 'package:elogir_home/features/automation/providers/automations_provider.dart';
import 'package:elogir_home/features/automation/widgets/expired_automations_list.dart';
import 'package:elogir_home/features/automation/widgets/one_time_timeline.dart';
import 'package:elogir_home/features/automation/widgets/recurring_automations_list.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Main automation screen with tab bar switching between recurring,
/// scheduled (active one-time), and expired (disabled one-time) automations.
class AutomationScreen extends ConsumerStatefulWidget {
  /// Creates the automation screen.
  const AutomationScreen({super.key});

  @override
  ConsumerState<AutomationScreen> createState() =>
      _AutomationScreenState();
}

class _AutomationScreenState
    extends ConsumerState<AutomationScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final recurringAsync = ref.watch(recurringAutomationsProvider);
    final activeOneTimeAsync =
        ref.watch(activeOneTimeAutomationsProvider);
    final expiredAsync =
        ref.watch(expiredOneTimeAutomationsProvider);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: const ElogirText(
          'Automation',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElogirIconButton(
              icon: FaIcon(
                FontAwesomeIcons.plus,
                size: 18,
                color: theme.colors.primary,
              ),
              onPressed: () => context.go('/add-automation'),
            ),
            ElogirPopupMenu(
              items: [
                ElogirPopupMenuItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.gear,
                    size: 16,
                  ),
                  label: 'Settings',
                  onPressed: () => context.push('/settings'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.md,
              vertical: theme.spacing.sm,
            ),
            child: ElogirTabBar(
              indicatorStyle: ElogirTabIndicatorStyle.pill,
              selectedIndex: _selectedTab,
              onChanged: (i) =>
                  setState(() => _selectedTab = i),
              tabs: const [
                ElogirTab(label: 'Recurring'),
                ElogirTab(label: 'Scheduled'),
                ElogirTab(label: 'Expired'),
              ],
            ),
          ),
          Expanded(
            child: switch (_selectedTab) {
              0 => recurringAsync.when(
                  loading: () =>
                      const Center(child: ElogirSpinner()),
                  error: (e, _) => _ErrorView(
                    error: e,
                    onRetry: () => ref.invalidate(
                      recurringAutomationsProvider,
                    ),
                  ),
                  data: (automations) =>
                      RecurringAutomationsList(
                    automations: automations,
                  ),
                ),
              1 => activeOneTimeAsync.when(
                  loading: () =>
                      const Center(child: ElogirSpinner()),
                  error: (e, _) => _ErrorView(
                    error: e,
                    onRetry: () => ref.invalidate(
                      activeOneTimeAutomationsProvider,
                    ),
                  ),
                  data: (automations) => OneTimeTimeline(
                    automations: automations,
                  ),
                ),
              2 => expiredAsync.when(
                  loading: () =>
                      const Center(child: ElogirSpinner()),
                  error: (e, _) => _ErrorView(
                    error: e,
                    onRetry: () => ref.invalidate(
                      expiredOneTimeAutomationsProvider,
                    ),
                  ),
                  data: (automations) =>
                      ExpiredAutomationsList(
                    automations: automations,
                  ),
                ),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            size: 40,
            color: theme.colors.error,
          ),
          SizedBox(height: theme.spacing.md),
          const ElogirText(
            'Something went wrong',
            variant: ElogirTextVariant.titleMedium,
          ),
          SizedBox(height: theme.spacing.xs),
          ElogirText(
            '$error',
            variant: ElogirTextVariant.bodySmall,
            style: TextStyle(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: theme.spacing.lg),
          ElogirButton(
            variant: ElogirButtonVariant.outlined,
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
