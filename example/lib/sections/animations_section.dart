import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class AnimationsSection extends StatefulWidget {
  const AnimationsSection({super.key});

  @override
  State<AnimationsSection> createState() => _AnimationsSectionState();
}

class _AnimationsSectionState extends State<AnimationsSection> {
  // FadeIn
  bool _showFadeIn = true;

  // AnimatedVisibility
  bool _visible = true;
  ElogirVisibilityTransition _visTransition = ElogirVisibilityTransition.fade;

  // AnimatedCounter
  int _counter = 1234;

  // Typewriter
  String _typewriterText = 'Hello, world! This is elogir_ui.';
  int _typewriterIndex = 0;
  static const _typewriterTexts = [
    'Hello, world! This is elogir_ui.',
    'Soft Industrial design system.',
    'Thick borders, warm neutrals, generous spacing.',
  ];

  // Pulse
  bool _pulseEnabled = true;

  // AnimatedSwap
  int _swapIndex = 0;

  // AnimatedGradient
  bool _gradientAlt = false;

  // SpringContainer
  bool _springExpanded = false;

  // Loading button
  bool _loading = false;

  // Progress bar
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Animations')),

        // ── FadeIn ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('FadeIn', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirButton(
          size: ElogirButtonSize.sm,
          onPressed: () => setState(() => _showFadeIn = !_showFadeIn),
          child: Text(_showFadeIn ? 'Reset' : 'Show'),
        ),
        SizedBox(height: theme.spacing.sm),
        if (_showFadeIn)
          ElogirFadeIn(
            key: ValueKey(_showFadeIn),
            direction: ElogirFadeInDirection.up,
            child: ElogirCard(
              child: Padding(
                padding: EdgeInsets.all(theme.spacing.md),
                child: ElogirText('Faded in from below'),
              ),
            ),
          ),

        // ── AnimatedVisibility ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('AnimatedVisibility', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: [
            ElogirButton(
              size: ElogirButtonSize.sm,
              onPressed: () => setState(() => _visible = !_visible),
              child: Text(_visible ? 'Hide' : 'Show'),
            ),
            for (final t in ElogirVisibilityTransition.values)
              ElogirButton(
                size: ElogirButtonSize.sm,
                variant: _visTransition == t
                    ? ElogirButtonVariant.filled
                    : ElogirButtonVariant.outlined,
                onPressed: () => setState(() => _visTransition = t),
                child: Text(t.name),
              ),
          ],
        ),
        SizedBox(height: theme.spacing.sm),
        ElogirAnimatedVisibility(
          visible: _visible,
          transition: _visTransition,
          duration: const Duration(milliseconds: 300),
          child: ElogirCard(
            child: Padding(
              padding: EdgeInsets.all(theme.spacing.md),
              child: ElogirText('Now you see me'),
            ),
          ),
        ),

        // ── StaggeredList ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('StaggeredList', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirStaggeredList(
          itemDelay: const Duration(milliseconds: 80),
          children: [
            for (int i = 0; i < 4; i++)
              Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.xs),
                child: ElogirCard(
                  child: Padding(
                    padding: EdgeInsets.all(theme.spacing.sm),
                    child: ElogirText('Item ${i + 1}'),
                  ),
                ),
              ),
          ],
        ),

        // ── AnimatedCounter ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('AnimatedCounter', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        Row(
          children: [
            ElogirAnimatedCounter(
              value: _counter,
              duration: const Duration(milliseconds: 800),
              separator: ',',
              style: theme.typography.headlineLarge.copyWith(
                color: colors.onBackground,
              ),
            ),
            SizedBox(width: theme.spacing.md),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () => setState(() => _counter += 573),
              child: const Text('+573'),
            ),
            SizedBox(width: theme.spacing.xs),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () => setState(() {
                _counter = (_counter - 573).clamp(0, 999999);
              }),
              child: const Text('-573'),
            ),
          ],
        ),

        // ── Typewriter ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('Typewriter', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirButton(
          size: ElogirButtonSize.sm,
          variant: ElogirButtonVariant.outlined,
          onPressed: () {
            setState(() {
              _typewriterIndex =
                  (_typewriterIndex + 1) % _typewriterTexts.length;
              _typewriterText = _typewriterTexts[_typewriterIndex];
            });
          },
          child: const Text('Next text'),
        ),
        SizedBox(height: theme.spacing.sm),
        ElogirTypewriter(
          key: ValueKey(_typewriterText),
          text: _typewriterText,
          speed: const Duration(milliseconds: 40),
          style: theme.typography.bodyLarge.copyWith(
            color: colors.onBackground,
          ),
        ),

        // ── Pulse ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('Pulse', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        Row(
          children: [
            ElogirPulse(
              enabled: _pulseEnabled,
              mode: ElogirPulseMode.both,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: ElogirText(
                    '!',
                    variant: ElogirTextVariant.titleMedium,
                    style: TextStyle(color: colors.onPrimary),
                  ),
                ),
              ),
            ),
            SizedBox(width: theme.spacing.md),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () =>
                  setState(() => _pulseEnabled = !_pulseEnabled),
              child: Text(_pulseEnabled ? 'Stop' : 'Start'),
            ),
          ],
        ),

        // ── AnimatedSwap ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('AnimatedSwap', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirButton(
          size: ElogirButtonSize.sm,
          variant: ElogirButtonVariant.outlined,
          onPressed: () => setState(() => _swapIndex = (_swapIndex + 1) % 3),
          child: const Text('Swap'),
        ),
        SizedBox(height: theme.spacing.sm),
        ElogirAnimatedSwap(
          transition: ElogirSwapTransition.slideUp,
          child: [
            ElogirTag(key: const ValueKey(0), label: 'First', variant: ElogirTagVariant.primary),
            ElogirTag(key: const ValueKey(1), label: 'Second', variant: ElogirTagVariant.success),
            ElogirTag(key: const ValueKey(2), label: 'Third', variant: ElogirTagVariant.warning),
          ][_swapIndex],
        ),

        // ── AnimatedGradient ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('AnimatedGradient', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirButton(
          size: ElogirButtonSize.sm,
          variant: ElogirButtonVariant.outlined,
          onPressed: () => setState(() => _gradientAlt = !_gradientAlt),
          child: const Text('Toggle gradient'),
        ),
        SizedBox(height: theme.spacing.sm),
        ClipRRect(
          borderRadius: theme.radii.md,
          child: ElogirAnimatedGradient(
            gradient: LinearGradient(
              colors: _gradientAlt
                  ? [colors.primary, colors.success]
                  : [colors.primaryContainer, colors.surfaceContainer],
            ),
            borderRadius: theme.radii.md,
            child: SizedBox(
              width: double.infinity,
              height: 80,
              child: Center(
                child: ElogirText(
                  'Gradient',
                  variant: ElogirTextVariant.titleMedium,
                  style: TextStyle(color: _gradientAlt ? colors.onPrimary : colors.onSurface),
                ),
              ),
            ),
          ),
        ),

        // ── SpringContainer ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('SpringContainer', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirButton(
          size: ElogirButtonSize.sm,
          variant: ElogirButtonVariant.outlined,
          onPressed: () =>
              setState(() => _springExpanded = !_springExpanded),
          child: Text(_springExpanded ? 'Collapse' : 'Expand'),
        ),
        SizedBox(height: theme.spacing.sm),
        ElogirSpringContainer(
          width: _springExpanded ? 300 : 120,
          height: _springExpanded ? 80 : 48,
          decoration: BoxDecoration(
            color: _springExpanded ? colors.primaryContainer : colors.surface,
            borderRadius: theme.radii.md,
            border: Border.all(
              color: colors.outline,
              width: theme.strokes.thick,
            ),
          ),
          alignment: Alignment.center,
          child: ElogirText(
            _springExpanded ? 'Expanded!' : 'Small',
            style: TextStyle(color: colors.onSurface),
          ),
        ),

        // ── Loading Button ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('Button Loading State', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        Wrap(
          spacing: theme.spacing.sm,
          children: [
            ElogirButton(
              loading: _loading,
              onPressed: () {
                setState(() => _loading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) setState(() => _loading = false);
                });
              },
              child: const Text('Submit'),
            ),
            ElogirButton(
              variant: ElogirButtonVariant.outlined,
              loading: _loading,
              onPressed: () {},
              child: const Text('Outlined'),
            ),
          ],
        ),

        // ── Progress Bar Shine ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('Progress Bar (shine at 100%)',
            variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        Wrap(
          spacing: theme.spacing.sm,
          children: [
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () =>
                  setState(() => _progress = (_progress + 0.25).clamp(0, 1)),
              child: const Text('+25%'),
            ),
            ElogirButton(
              size: ElogirButtonSize.sm,
              variant: ElogirButtonVariant.outlined,
              onPressed: () => setState(() => _progress = 0),
              child: const Text('Reset'),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.sm),
        Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.md),
          child: ElogirProgressBar(
            value: _progress,
            showPercentage: true,
            label: const Text('Upload'),
          ),
        ),

        // ── Marquee ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('Marquee', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        Container(
          width: 220,
          padding: EdgeInsets.all(theme.spacing.sm),
          decoration: BoxDecoration(
            border: Border.all(
              color: colors.outline,
              width: theme.strokes.medium,
            ),
            borderRadius: theme.radii.md,
          ),
          child: ElogirMarquee(
            child: Text(
              'This is a very long text that will scroll continuously because it overflows the container',
              style: theme.typography.bodyMedium.copyWith(
                color: colors.onSurface,
              ),
            ),
          ),
        ),

        // ── Curves Info ──
        SizedBox(height: theme.spacing.lg),
        ElogirText('Curves', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirText(
          'ElogirCurves: .snappy, .gentle, .spring, .decelerate',
          variant: ElogirTextVariant.caption,
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
        ElogirText(
          'Used throughout the library for consistent motion feel.',
          variant: ElogirTextVariant.caption,
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}
