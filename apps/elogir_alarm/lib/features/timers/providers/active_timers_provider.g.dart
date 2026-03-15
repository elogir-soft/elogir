// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_timers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages in-memory timer ticking with periodic Drift persistence.
///
/// Loads initial state from Drift, ticks running timers every 100ms,
/// and flushes state to Drift every 5 seconds. On Android, schedules
/// native alarms via the `alarm` package so timers ring even when the
/// app is closed.

@ProviderFor(ActiveTimers)
final activeTimersProvider = ActiveTimersProvider._();

/// Manages in-memory timer ticking with periodic Drift persistence.
///
/// Loads initial state from Drift, ticks running timers every 100ms,
/// and flushes state to Drift every 5 seconds. On Android, schedules
/// native alarms via the `alarm` package so timers ring even when the
/// app is closed.
final class ActiveTimersProvider
    extends $NotifierProvider<ActiveTimers, List<AppTimer>> {
  /// Manages in-memory timer ticking with periodic Drift persistence.
  ///
  /// Loads initial state from Drift, ticks running timers every 100ms,
  /// and flushes state to Drift every 5 seconds. On Android, schedules
  /// native alarms via the `alarm` package so timers ring even when the
  /// app is closed.
  ActiveTimersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeTimersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeTimersHash();

  @$internal
  @override
  ActiveTimers create() => ActiveTimers();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AppTimer> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AppTimer>>(value),
    );
  }
}

String _$activeTimersHash() => r'c935b61d7664f1a0928cc6c543b5799c3820fb7e';

/// Manages in-memory timer ticking with periodic Drift persistence.
///
/// Loads initial state from Drift, ticks running timers every 100ms,
/// and flushes state to Drift every 5 seconds. On Android, schedules
/// native alarms via the `alarm` package so timers ring even when the
/// app is closed.

abstract class _$ActiveTimers extends $Notifier<List<AppTimer>> {
  List<AppTimer> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<AppTimer>, List<AppTimer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AppTimer>, List<AppTimer>>,
              List<AppTimer>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
