// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation_scheduler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(automationScheduler)
final automationSchedulerProvider = AutomationSchedulerProvider._();

final class AutomationSchedulerProvider
    extends
        $FunctionalProvider<
          AutomationScheduler,
          AutomationScheduler,
          AutomationScheduler
        >
    with $Provider<AutomationScheduler> {
  AutomationSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'automationSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$automationSchedulerHash();

  @$internal
  @override
  $ProviderElement<AutomationScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AutomationScheduler create(Ref ref) {
    return automationScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutomationScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutomationScheduler>(value),
    );
  }
}

String _$automationSchedulerHash() =>
    r'3c41383fdd76132ae49b34be6d2bec816c771e13';
