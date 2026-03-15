import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Calculator display showing the expression and result/preview.
class CalcDisplay extends StatelessWidget {
  const CalcDisplay({
    required this.expression,
    required this.display,
    required this.preview,
    required this.hasError,
    required this.justEvaluated,
    super.key,
  });

  final String expression;
  final String display;
  final String preview;
  final bool hasError;
  final bool justEvaluated;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirCard(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Expression line
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                justEvaluated ? expression : expression.isEmpty ? '' : expression,
                style: theme.typography.headlineSmall.copyWith(
                  color: justEvaluated
                      ? theme.colors.onSurfaceVariant
                      : theme.colors.onSurface,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: theme.spacing.xs),
            // Result / preview line
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                justEvaluated
                    ? display
                    : preview.isNotEmpty
                        ? preview
                        : (hasError ? display : ''),
                style: theme.typography.displaySmall.copyWith(
                  color: hasError
                      ? theme.colors.error
                      : justEvaluated
                          ? theme.colors.onSurface
                          : theme.colors.onSurfaceVariant,
                  fontWeight: justEvaluated ? FontWeight.w700 : FontWeight.w400,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
