// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elogir_auto_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(elogirAuto)
final elogirAutoProvider = ElogirAutoProvider._();

final class ElogirAutoProvider
    extends $FunctionalProvider<ElogirAuto, ElogirAuto, ElogirAuto>
    with $Provider<ElogirAuto> {
  ElogirAutoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'elogirAutoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$elogirAutoHash();

  @$internal
  @override
  $ProviderElement<ElogirAuto> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ElogirAuto create(Ref ref) {
    return elogirAuto(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ElogirAuto value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ElogirAuto>(value),
    );
  }
}

String _$elogirAutoHash() => r'ec76fbe726970630c20d401f1249337c21a5c6ad';
