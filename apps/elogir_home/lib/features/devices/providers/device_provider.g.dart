// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(device)
final deviceProvider = DeviceFamily._();

final class DeviceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SmartDevice?>,
          SmartDevice?,
          FutureOr<SmartDevice?>
        >
    with $FutureModifier<SmartDevice?>, $FutureProvider<SmartDevice?> {
  DeviceProvider._({
    required DeviceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'deviceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deviceHash();

  @override
  String toString() {
    return r'deviceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SmartDevice?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SmartDevice?> create(Ref ref) {
    final argument = this.argument as String;
    return device(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeviceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deviceHash() => r'caf93be713111e81d2d08149a0afca27ce05b361';

final class DeviceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SmartDevice?>, String> {
  DeviceFamily._()
    : super(
        retry: null,
        name: r'deviceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeviceProvider call(String deviceId) =>
      DeviceProvider._(argument: deviceId, from: this);

  @override
  String toString() => r'deviceProvider';
}
