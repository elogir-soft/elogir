import 'package:elogir_auto/elogir_auto.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Returns a FontAwesome icon appropriate for the given [DeviceType].
class DeviceTypeIcon extends StatelessWidget {
  /// Creates an icon for the given device [type].
  const DeviceTypeIcon({
    required this.type,
    this.size = 18,
    this.color,
    super.key,
  });

  /// The device type to display an icon for.
  final DeviceType type;

  /// Icon size in logical pixels.
  final double size;

  /// Optional icon color override.
  final Color? color;

  /// Returns a human-readable label for the given [DeviceType].
  static String labelFor(DeviceType type) => switch (type) {
        DeviceType.light => 'Light',
        DeviceType.switchDevice => 'Switch',
        DeviceType.cover => 'Cover',
      };

  @override
  Widget build(BuildContext context) {
    final iconData = switch (type) {
      DeviceType.light => FontAwesomeIcons.lightbulb,
      DeviceType.switchDevice => FontAwesomeIcons.plug,
      DeviceType.cover => FontAwesomeIcons.windowMaximize,
    };

    return FaIcon(iconData, size: size, color: color);
  }
}
