// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Bridges elogir_auto's rxdart-based [DeviceController] into Riverpod.
///
/// Connects/disconnects the controller on lifecycle, subscribes to its
/// state stream, and forwards state updates into Riverpod async state.

@ProviderFor(DeviceControllerNotifier)
final deviceControllerProvider = DeviceControllerNotifierFamily._();

/// Bridges elogir_auto's rxdart-based [DeviceController] into Riverpod.
///
/// Connects/disconnects the controller on lifecycle, subscribes to its
/// state stream, and forwards state updates into Riverpod async state.
final class DeviceControllerNotifierProvider
    extends $AsyncNotifierProvider<DeviceControllerNotifier, dynamic> {
  /// Bridges elogir_auto's rxdart-based [DeviceController] into Riverpod.
  ///
  /// Connects/disconnects the controller on lifecycle, subscribes to its
  /// state stream, and forwards state updates into Riverpod async state.
  DeviceControllerNotifierProvider._({
    required DeviceControllerNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'deviceControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deviceControllerNotifierHash();

  @override
  String toString() {
    return r'deviceControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DeviceControllerNotifier create() => DeviceControllerNotifier();

  @override
  bool operator ==(Object other) {
    return other is DeviceControllerNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deviceControllerNotifierHash() =>
    r'3b1d550a2df04765a782646a5e6a9d51ed64c5f0';

/// Bridges elogir_auto's rxdart-based [DeviceController] into Riverpod.
///
/// Connects/disconnects the controller on lifecycle, subscribes to its
/// state stream, and forwards state updates into Riverpod async state.

final class DeviceControllerNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DeviceControllerNotifier,
          AsyncValue<dynamic>,
          dynamic,
          FutureOr<dynamic>,
          String
        > {
  DeviceControllerNotifierFamily._()
    : super(
        retry: null,
        name: r'deviceControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bridges elogir_auto's rxdart-based [DeviceController] into Riverpod.
  ///
  /// Connects/disconnects the controller on lifecycle, subscribes to its
  /// state stream, and forwards state updates into Riverpod async state.

  DeviceControllerNotifierProvider call(String deviceId) =>
      DeviceControllerNotifierProvider._(argument: deviceId, from: this);

  @override
  String toString() => r'deviceControllerProvider';
}

/// Bridges elogir_auto's rxdart-based [DeviceController] into Riverpod.
///
/// Connects/disconnects the controller on lifecycle, subscribes to its
/// state stream, and forwards state updates into Riverpod async state.

abstract class _$DeviceControllerNotifier extends $AsyncNotifier<dynamic> {
  late final _$args = ref.$arg as String;
  String get deviceId => _$args;

  FutureOr<dynamic> build(String deviceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<dynamic>, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<dynamic>, dynamic>,
              AsyncValue<dynamic>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
