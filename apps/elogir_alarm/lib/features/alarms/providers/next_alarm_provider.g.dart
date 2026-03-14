// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_alarm_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Derives the soonest enabled alarm from the alarms list.

@ProviderFor(nextAlarm)
final nextAlarmProvider = NextAlarmProvider._();

/// Derives the soonest enabled alarm from the alarms list.

final class NextAlarmProvider
    extends $FunctionalProvider<Alarm?, Alarm?, Alarm?>
    with $Provider<Alarm?> {
  /// Derives the soonest enabled alarm from the alarms list.
  NextAlarmProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nextAlarmProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nextAlarmHash();

  @$internal
  @override
  $ProviderElement<Alarm?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Alarm? create(Ref ref) {
    return nextAlarm(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Alarm? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Alarm?>(value),
    );
  }
}

String _$nextAlarmHash() => r'81b537d7e832c5d360315a67ef31b1236b7468f2';
