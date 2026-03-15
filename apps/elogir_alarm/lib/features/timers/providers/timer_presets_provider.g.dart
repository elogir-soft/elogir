// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_presets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timerPresets)
final timerPresetsProvider = TimerPresetsProvider._();

final class TimerPresetsProvider
    extends $FunctionalProvider<List<int>, List<int>, List<int>>
    with $Provider<List<int>> {
  TimerPresetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timerPresetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timerPresetsHash();

  @$internal
  @override
  $ProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<int> create(Ref ref) {
    return timerPresets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<int>>(value),
    );
  }
}

String _$timerPresetsHash() => r'b75379bc8f9f46d516ac831818347d52de7ab13c';
