// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_scheduler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The platform-appropriate native alarm scheduler.
///
/// Overridden in bootstrap with [AlarmScheduler.create()] after [init()].

@ProviderFor(alarmScheduler)
final alarmSchedulerProvider = AlarmSchedulerProvider._();

/// The platform-appropriate native alarm scheduler.
///
/// Overridden in bootstrap with [AlarmScheduler.create()] after [init()].

final class AlarmSchedulerProvider
    extends $FunctionalProvider<AlarmScheduler, AlarmScheduler, AlarmScheduler>
    with $Provider<AlarmScheduler> {
  /// The platform-appropriate native alarm scheduler.
  ///
  /// Overridden in bootstrap with [AlarmScheduler.create()] after [init()].
  AlarmSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmSchedulerHash();

  @$internal
  @override
  $ProviderElement<AlarmScheduler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AlarmScheduler create(Ref ref) {
    return alarmScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlarmScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlarmScheduler>(value),
    );
  }
}

String _$alarmSchedulerHash() => r'b604531e763d8546b26ada452ed4ae33b2ef57d0';
