// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timerRepository)
final timerRepositoryProvider = TimerRepositoryProvider._();

final class TimerRepositoryProvider
    extends
        $FunctionalProvider<TimerRepository, TimerRepository, TimerRepository>
    with $Provider<TimerRepository> {
  TimerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timerRepositoryHash();

  @$internal
  @override
  $ProviderElement<TimerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimerRepository create(Ref ref) {
    return timerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimerRepository>(value),
    );
  }
}

String _$timerRepositoryHash() => r'00486e4b5f71ae758a8a75db42bbdd09fb8ab1b0';
