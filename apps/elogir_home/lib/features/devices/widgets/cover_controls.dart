import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
/// Controls for a cover device: open/stop/close buttons and position bar.
class CoverControls extends StatelessWidget {
  const CoverControls({
    required this.state,
    required this.controller,
    super.key,
  });

  final CoverState state;
  final CoverController controller;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Position
        ElogirCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElogirText(
                'Position: ${state.position}%',
                variant: ElogirTextVariant.bodyMedium,
              ),
              SizedBox(height: theme.spacing.sm),
              ElogirProgressBar(
                value: state.position / 100,
              ),
              SizedBox(height: theme.spacing.xs),
              Row(
                children: [
                  ElogirText(
                    state.isMoving
                        ? 'Moving ${state.direction.name}'
                        : 'Stopped',
                    variant: ElogirTextVariant.bodySmall,
                    style: TextStyle(color: theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: theme.spacing.md),

        // Control buttons
        ElogirCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElogirButton(
                variant: ElogirButtonVariant.outlined,
                onPressed: controller.open,
                child: const Text('Open'),
              ),
              ElogirButton(
                variant: ElogirButtonVariant.outlined,
                onPressed: controller.stop,
                child: const Text('Stop'),
              ),
              ElogirButton(
                variant: ElogirButtonVariant.outlined,
                onPressed: controller.close,
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
