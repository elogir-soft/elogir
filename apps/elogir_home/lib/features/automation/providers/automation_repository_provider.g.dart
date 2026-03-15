// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(automationRepository)
final automationRepositoryProvider = AutomationRepositoryProvider._();

final class AutomationRepositoryProvider
    extends
        $FunctionalProvider<
          AutomationRepository,
          AutomationRepository,
          AutomationRepository
        >
    with $Provider<AutomationRepository> {
  AutomationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'automationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$automationRepositoryHash();

  @$internal
  @override
  $ProviderElement<AutomationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AutomationRepository create(Ref ref) {
    return automationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutomationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutomationRepository>(value),
    );
  }
}

String _$automationRepositoryHash() =>
    r'89a8bd35dae5f8d9e93e957895d342b9950fed0f';
