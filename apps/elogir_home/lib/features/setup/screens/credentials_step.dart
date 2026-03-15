import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Step 2: Enter Tuya API credentials or choose LAN scan.
class CredentialsStep extends StatefulWidget {
  const CredentialsStep({
    required this.onCredentialsSubmitted,
    required this.onScanSelected,
    this.initialCredentials,
    super.key,
  });

  final ValueChanged<TuyaCredentials> onCredentialsSubmitted;
  final VoidCallback onScanSelected;
  final TuyaCredentials? initialCredentials;

  @override
  State<CredentialsStep> createState() => _CredentialsStepState();
}

class _CredentialsStepState extends State<CredentialsStep> {
  late final TextEditingController _apiKeyController;
  late final TextEditingController _apiSecretController;
  late final TextEditingController _regionController;

  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController(
      text: widget.initialCredentials?.apiKey ?? '',
    );
    _apiSecretController = TextEditingController(
      text: widget.initialCredentials?.apiSecret ?? '',
    );
    _regionController = TextEditingController(
      text: widget.initialCredentials?.region ?? 'eu',
    );
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _apiSecretController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  void _submit() {
    final apiKey = _apiKeyController.text.trim();
    final apiSecret = _apiSecretController.text.trim();
    final region = _regionController.text.trim();

    if (apiKey.isEmpty || apiSecret.isEmpty || region.isEmpty) return;

    widget.onCredentialsSubmitted(
      TuyaCredentials(
        apiKey: apiKey,
        apiSecret: apiSecret,
        region: region,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Padding(
      padding: EdgeInsets.all(theme.spacing.md),
      child: ListView(
        children: [
          const ElogirText(
            'Tuya Credentials',
            variant: ElogirTextVariant.headlineSmall,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirText(
            'Enter your Tuya IoT Cloud API credentials, or scan your '
            'local network to find devices.',
            variant: ElogirTextVariant.bodyMedium,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.lg),

          ElogirTextField(
            controller: _apiKeyController,
            label: 'API Key',
            hint: 'Your Tuya API key',
          ),
          SizedBox(height: theme.spacing.md),

          ElogirTextField(
            controller: _apiSecretController,
            label: 'API Secret',
            hint: 'Your Tuya API secret',
          ),
          SizedBox(height: theme.spacing.md),

          ElogirTextField(
            controller: _regionController,
            label: 'Region',
            hint: 'e.g. eu, us, cn',
          ),
          SizedBox(height: theme.spacing.lg),

          ElogirButton(
            onPressed: _submit,
            child: const Text('Fetch Cloud Devices'),
          ),

          SizedBox(height: theme.spacing.md),

          Center(
            child: ElogirText(
              'or',
              variant: ElogirTextVariant.bodyMedium,
              style: TextStyle(color: theme.colors.onSurfaceVariant),
            ),
          ),

          SizedBox(height: theme.spacing.md),

          ElogirButton(
            variant: ElogirButtonVariant.outlined,
            onPressed: widget.onScanSelected,
            child: const Text('Scan Local Network'),
          ),
        ],
      ),
    );
  }
}
