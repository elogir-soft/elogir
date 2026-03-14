// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stopwatch_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages stopwatch state with high-frequency tick updates.
///
/// Uses [Timer.periodic] for ~60fps updates. Ephemeral — no persistence.

@ProviderFor(StopwatchNotifier)
final stopwatchProvider = StopwatchNotifierProvider._();

/// Manages stopwatch state with high-frequency tick updates.
///
/// Uses [Timer.periodic] for ~60fps updates. Ephemeral — no persistence.
final class StopwatchNotifierProvider
    extends $NotifierProvider<StopwatchNotifier, StopwatchState> {
  /// Manages stopwatch state with high-frequency tick updates.
  ///
  /// Uses [Timer.periodic] for ~60fps updates. Ephemeral — no persistence.
  StopwatchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stopwatchProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stopwatchNotifierHash();

  @$internal
  @override
  StopwatchNotifier create() => StopwatchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StopwatchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StopwatchState>(value),
    );
  }
}

String _$stopwatchNotifierHash() => r'900e061ab6f383f83aee3f2f671b87f61b0374ad';

/// Manages stopwatch state with high-frequency tick updates.
///
/// Uses [Timer.periodic] for ~60fps updates. Ephemeral — no persistence.

abstract class _$StopwatchNotifier extends $Notifier<StopwatchState> {
  StopwatchState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<StopwatchState, StopwatchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StopwatchState, StopwatchState>,
              StopwatchState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
