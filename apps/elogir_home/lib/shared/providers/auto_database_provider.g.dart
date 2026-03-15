// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(autoDatabase)
final autoDatabaseProvider = AutoDatabaseProvider._();

final class AutoDatabaseProvider
    extends $FunctionalProvider<AutoDatabase, AutoDatabase, AutoDatabase>
    with $Provider<AutoDatabase> {
  AutoDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoDatabaseHash();

  @$internal
  @override
  $ProviderElement<AutoDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AutoDatabase create(Ref ref) {
    return autoDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutoDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutoDatabase>(value),
    );
  }
}

String _$autoDatabaseHash() => r'08d1e64c442a7c6f769ce561dba8bf231d47bf38';
