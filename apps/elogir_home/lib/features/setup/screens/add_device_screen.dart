import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/devices/providers/device_repository_provider.dart';
import 'package:elogir_home/features/setup/models/setup_state.dart';
import 'package:elogir_home/features/setup/providers/cloud_devices_provider.dart';
import 'package:elogir_home/features/setup/providers/credentials_service_provider.dart';
import 'package:elogir_home/features/setup/providers/scan_results_provider.dart';
import 'package:elogir_home/features/setup/screens/credentials_step.dart';
import 'package:elogir_home/features/setup/screens/device_configure_step.dart';
import 'package:elogir_home/features/setup/screens/device_list_step.dart';
import 'package:elogir_home/features/setup/screens/platform_select_step.dart';
import 'package:elogir_home/shared/providers/elogir_auto_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

/// Multi-step flow for adding a new smart device.
class AddDeviceScreen extends ConsumerStatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  ConsumerState<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends ConsumerState<AddDeviceScreen> {
  SetupState _state = const SetupState();
  bool _isLoading = false;

  void _goBack() {
    if (_state.currentStep > 0) {
      setState(() {
        _state = _state.copyWith(currentStep: _state.currentStep - 1);
      });
    } else {
      context.go('/devices');
    }
  }

  Future<void> _onPlatformSelected(String platform) async {
    // Load saved credentials if available.
    final credentialsService = ref.read(credentialsServiceProvider);
    final savedCredentials = await credentialsService.getTuyaCredentials();

    setState(() {
      _state = _state.copyWith(
        selectedPlatform: platform,
        credentials: savedCredentials,
        currentStep: 1,
      );
    });
  }

  Future<void> _onCredentialsSubmitted(TuyaCredentials credentials) async {
    setState(() => _isLoading = true);

    try {
      // Save credentials for next time.
      await ref
          .read(credentialsServiceProvider)
          .saveTuyaCredentials(credentials);

      // Wire cloud service into elogirAuto so cloud control is available.
      final elogirAuto = ref.read(elogirAutoProvider);
      if (!elogirAuto.hasCloudService) {
        final cloudService = elogirAuto.createTuyaCloudService(credentials);
        await cloudService.init();
        elogirAuto.setCloudService(cloudService);
      }

      // Fetch cloud devices and run a LAN scan in parallel for IP
      // cross-referencing.
      final results = await Future.wait([
        ref.read(cloudDevicesProvider(credentials).future),
        ref
            .read(scanResultsProvider.future)
            .then<List<ScanResult>>((v) => v)
            .onError((_, __) => <ScanResult>[]),
      ]);

      final devices = results[0] as List<Map<String, dynamic>>;
      final scanResults = results[1] as List<ScanResult>;

      setState(() {
        _state = _state.copyWith(
          credentials: credentials,
          cloudDevices: devices,
          scanResults: scanResults,
          useLanScan: false,
          currentStep: 2,
        );
        _isLoading = false;
      });
    } on Exception {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _onScanSelected() async {
    setState(() => _isLoading = true);

    try {
      final results = await ref.read(scanResultsProvider.future);

      setState(() {
        _state = _state.copyWith(
          scanResults: results,
          useLanScan: true,
          currentStep: 2,
        );
        _isLoading = false;
      });
    } on Exception {
      setState(() => _isLoading = false);
    }
  }

  void _onDeviceSelected(String deviceId) {
    String? address;
    String? localKey;
    String name = '';

    if (_state.useLanScan) {
      final result =
          _state.scanResults.where((r) => r.deviceId == deviceId).firstOrNull;
      address = result?.ip;
    } else {
      final device = _state.cloudDevices
          .where((d) => (d['id'] as String?) == deviceId)
          .firstOrNull;
      name = (device?['name'] as String?) ?? '';
      localKey = device?['local_key'] as String?;

      // Cross-reference with LAN scan results to find local IP.
      final scanMatch = _state.scanResults
          .where((r) => r.deviceId == deviceId)
          .firstOrNull;
      address = scanMatch?.ip;
    }

    setState(() {
      _state = _state.copyWith(
        selectedDeviceId: deviceId,
        deviceName: name,
        deviceAddress: address,
        localKey: localKey,
        currentStep: 3,
      );
    });
  }

  Future<void> _onSave(
    String name,
    DeviceType type, {
    String? address,
    String? localKey,
  }) async {
    if (_state.selectedDeviceId == null) return;

    final device = SmartDevice(
      id: const Uuid().v4(),
      name: name,
      type: type,
      connection: DeviceConnection.tuya(
        deviceId: _state.selectedDeviceId!,
        address: address ?? '',
        localKey: localKey ?? '',
        version: _state.deviceVersion,
      ),
    );

    await ref.read(deviceRepositoryProvider).save(device);

    if (mounted) {
      context.go('/devices');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: const ElogirText(
          'Add Device',
          variant: ElogirTextVariant.titleLarge,
        ),
        leading: ElogirIconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
          onPressed: _goBack,
        ),
      ),
      body: _isLoading
          ? const Center(child: ElogirSpinner())
          : switch (_state.currentStep) {
              0 => PlatformSelectStep(
                  onPlatformSelected: _onPlatformSelected,
                ),
              1 => CredentialsStep(
                  initialCredentials: _state.credentials,
                  onCredentialsSubmitted: _onCredentialsSubmitted,
                  onScanSelected: _onScanSelected,
                ),
              2 => DeviceListStep(
                  cloudDevices: _state.cloudDevices,
                  scanResults: _state.scanResults,
                  selectedDeviceId: _state.selectedDeviceId,
                  useLanScan: _state.useLanScan,
                  onDeviceSelected: _onDeviceSelected,
                ),
              3 => DeviceConfigureStep(
                  deviceId: _state.selectedDeviceId ?? '',
                  initialName: _state.deviceName,
                  initialType: _state.deviceType,
                  initialAddress: _state.deviceAddress,
                  initialLocalKey: _state.localKey,
                  onSave: _onSave,
                ),
              _ => const SizedBox.shrink(),
            },
    );
  }
}
