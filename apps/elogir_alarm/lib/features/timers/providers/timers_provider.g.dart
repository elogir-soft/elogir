// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Watches all persisted timers from Drift.

@ProviderFor(persistedTimers)
final persistedTimersProvider = PersistedTimersProvider._();

/// Watches all persisted timers from Drift.

final class PersistedTimersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppTimer>>,
          List<AppTimer>,
          Stream<List<AppTimer>>
        >
    with $FutureModifier<List<AppTimer>>, $StreamProvider<List<AppTimer>> {
  /// Watches all persisted timers from Drift.
  PersistedTimersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'persistedTimersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$persistedTimersHash();

  @$internal
  @override
  $StreamProviderElement<List<AppTimer>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AppTimer>> create(Ref ref) {
    return persistedTimers(ref);
  }
}

String _$persistedTimersHash() => r'09fdf6b82341abfb07cbbc01d355ff95d075c6f7';
