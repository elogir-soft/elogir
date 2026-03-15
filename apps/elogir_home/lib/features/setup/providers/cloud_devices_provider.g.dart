// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_devices_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cloudDevices)
final cloudDevicesProvider = CloudDevicesFamily._();

final class CloudDevicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  CloudDevicesProvider._({
    required CloudDevicesFamily super.from,
    required TuyaCredentials super.argument,
  }) : super(
         retry: null,
         name: r'cloudDevicesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cloudDevicesHash();

  @override
  String toString() {
    return r'cloudDevicesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as TuyaCredentials;
    return cloudDevices(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CloudDevicesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cloudDevicesHash() => r'd3f5e8754c5dbfea391688b091e6189f472b1b65';

final class CloudDevicesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Map<String, dynamic>>>,
          TuyaCredentials
        > {
  CloudDevicesFamily._()
    : super(
        retry: null,
        name: r'cloudDevicesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CloudDevicesProvider call(TuyaCredentials credentials) =>
      CloudDevicesProvider._(argument: credentials, from: this);

  @override
  String toString() => r'cloudDevicesProvider';
}
