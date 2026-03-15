import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Step 4: Configure device name, type, and review connection details.
class DeviceConfigureStep extends StatefulWidget {
  const DeviceConfigureStep({
    required this.deviceId,
    required this.initialName,
    required this.initialType,
    required this.initialAddress,
    required this.initialLocalKey,
    required this.onSave,
    super.key,
  });

  final String deviceId;
  final String initialName;
  final DeviceType initialType;
  final String? initialAddress;
  final String? initialLocalKey;
  final void Function(
    String name,
    DeviceType type, {
    String? address,
    String? localKey,
  }) onSave;

  @override
  State<DeviceConfigureStep> createState() => _DeviceConfigureStepState();
}

class _DeviceConfigureStepState extends State<DeviceConfigureStep> {
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _localKeyController;
  late DeviceType _selectedType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _addressController =
        TextEditingController(text: widget.initialAddress ?? '');
    _localKeyController =
        TextEditingController(text: widget.initialLocalKey ?? '');
    _selectedType = widget.initialType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _localKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Padding(
      padding: EdgeInsets.all(theme.spacing.md),
      child: ListView(
        children: [
          const ElogirText(
            'Configure Device',
            variant: ElogirTextVariant.headlineSmall,
          ),
          SizedBox(height: theme.spacing.lg),

          ElogirTextField(
            controller: _nameController,
            label: 'Device Name',
            hint: 'e.g. Living Room Light',
          ),
          SizedBox(height: theme.spacing.md),

          const ElogirText(
            'Device Type',
            variant: ElogirTextVariant.labelLarge,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirSegmentedControl<DeviceType>(
            selected: _selectedType,
            segments: const [
              ElogirSegment(value: DeviceType.light, label: 'Light'),
              ElogirSegment(
                value: DeviceType.switchDevice,
                label: 'Switch',
              ),
              ElogirSegment(value: DeviceType.cover, label: 'Cover'),
            ],
            onChanged: (type) => setState(() => _selectedType = type),
          ),

          SizedBox(height: theme.spacing.lg),

          // Connection details
          ElogirCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ElogirText(
                  'Connection Details',
                  variant: ElogirTextVariant.labelLarge,
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirText(
                  'Device ID: ${widget.deviceId}',
                  variant: ElogirTextVariant.bodySmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
                SizedBox(height: theme.spacing.md),
                ElogirTextField(
                  controller: _addressController,
                  label: 'LAN IP Address (optional)',
                  hint: 'e.g. 192.168.1.100',
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirTextField(
                  controller: _localKeyController,
                  label: 'Local Key (optional)',
                  hint: 'Required for LAN control',
                ),
              ],
            ),
          ),

          SizedBox(height: theme.spacing.lg),

          ElogirButton(
            onPressed: () {
              final name = _nameController.text.trim();
              if (name.isEmpty) return;
              final address = _addressController.text.trim();
              final localKey = _localKeyController.text.trim();
              widget.onSave(
                name,
                _selectedType,
                address: address.isEmpty ? null : address,
                localKey: localKey.isEmpty ? null : localKey,
              );
            },
            child: const Text('Save Device'),
          ),
        ],
      ),
    );
  }
}
