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
        isAutoDispose: true,
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

String _$persistedTimersHash() => r'05da208115cd5299d3a3ab93321e929688d921a3';
