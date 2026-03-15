// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(credentialsService)
final credentialsServiceProvider = CredentialsServiceProvider._();

final class CredentialsServiceProvider
    extends
        $FunctionalProvider<
          CredentialsService,
          CredentialsService,
          CredentialsService
        >
    with $Provider<CredentialsService> {
  CredentialsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'credentialsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$credentialsServiceHash();

  @$internal
  @override
  $ProviderElement<CredentialsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CredentialsService create(Ref ref) {
    return credentialsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CredentialsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CredentialsService>(value),
    );
  }
}

String _$credentialsServiceHash() =>
    r'71fa9b946dd67f16ee1f800c309b1a2161caefb2';
