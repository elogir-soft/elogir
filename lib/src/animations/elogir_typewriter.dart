import 'dart:async';

import 'package:flutter/widgets.dart';

/// Types out text character by character with a blinking cursor.
///
/// ```dart
/// ElogirTypewriter(
///   text: 'Hello, world!',
///   style: theme.typography.bodyLarge,
/// )
/// ```
class ElogirTypewriter extends StatefulWidget {
  const ElogirTypewriter({
    super.key,
    required this.text,
    this.speed = const Duration(milliseconds: 50),
    this.style,
    this.showCursor = true,
    this.cursor = '|',
    this.cursorBlinkSpeed = const Duration(milliseconds: 500),
    this.onComplete,
    this.startDelay = Duration.zero,
  });

  /// The full text to type out.
  final String text;

  /// Duration per character.
  final Duration speed;

  final TextStyle? style;

  /// Whether to show a blinking cursor at the end.
  final bool showCursor;

  /// Cursor character.
  final String cursor;

  /// Blink speed for the cursor.
  final Duration cursorBlinkSpeed;

  /// Called when the full text has been typed out.
  final VoidCallback? onComplete;

  /// Delay before typing starts.
  final Duration startDelay;

  @override
  State<ElogirTypewriter> createState() => _ElogirTypewriterState();
}

class _ElogirTypewriterState extends State<ElogirTypewriter> {
  int _charCount = 0;
  bool _cursorVisible = true;
  Timer? _typeTimer;
  Timer? _cursorTimer;
  bool _complete = false;

  @override
  void initState() {
    super.initState();
    if (widget.startDelay == Duration.zero) {
      _startTyping();
    } else {
      Future.delayed(widget.startDelay, () {
        if (mounted) _startTyping();
      });
    }
    if (widget.showCursor) {
      _cursorTimer = Timer.periodic(widget.cursorBlinkSpeed, (_) {
        if (mounted) setState(() => _cursorVisible = !_cursorVisible);
      });
    }
  }

  void _startTyping() {
    _typeTimer = Timer.periodic(widget.speed, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_charCount < widget.text.length) {
        setState(() => _charCount++);
      } else {
        timer.cancel();
        _complete = true;
        widget.onComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(ElogirTypewriter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _typeTimer?.cancel();
      _charCount = 0;
      _complete = false;
      _startTyping();
    }
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = widget.text.substring(0, _charCount);
    final cursorChar =
        widget.showCursor && _cursorVisible ? widget.cursor : '';

    return Text.rich(
      TextSpan(
        text: displayText,
        children: [
          if (!_complete || widget.showCursor)
            TextSpan(
              text: cursorChar,
              style: widget.style?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ),
      style: widget.style,
    );
  }
}
