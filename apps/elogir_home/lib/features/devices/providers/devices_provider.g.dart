// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(devices)
final devicesProvider = DevicesProvider._();

final class DevicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SmartDevice>>,
          List<SmartDevice>,
          Stream<List<SmartDevice>>
        >
    with
        $FutureModifier<List<SmartDevice>>,
        $StreamProvider<List<SmartDevice>> {
  DevicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devicesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devicesHash();

  @$internal
  @override
  $StreamProviderElement<List<SmartDevice>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<SmartDevice>> create(Ref ref) {
    return devices(ref);
  }
}

String _$devicesHash() => r'e30571d1293de03a75d5c8f5ba8de5d3aa878a89';
