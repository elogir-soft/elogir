// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(automations)
final automationsProvider = AutomationsProvider._();

final class AutomationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Automation>>,
          List<Automation>,
          Stream<List<Automation>>
        >
    with $FutureModifier<List<Automation>>, $StreamProvider<List<Automation>> {
  AutomationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'automationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$automationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Automation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Automation>> create(Ref ref) {
    return automations(ref);
  }
}

String _$automationsHash() => r'cd3236c9becd6f46acdffaa8da5999b5bfaf06cc';

@ProviderFor(recurringAutomations)
final recurringAutomationsProvider = RecurringAutomationsProvider._();

final class RecurringAutomationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Automation>>,
          List<Automation>,
          Stream<List<Automation>>
        >
    with $FutureModifier<List<Automation>>, $StreamProvider<List<Automation>> {
  RecurringAutomationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringAutomationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringAutomationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Automation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Automation>> create(Ref ref) {
    return recurringAutomations(ref);
  }
}

String _$recurringAutomationsHash() =>
    r'7703f4b6615b2254111f98fb37ca3d5eab959dd2';

@ProviderFor(oneTimeAutomations)
final oneTimeAutomationsProvider = OneTimeAutomationsProvider._();

final class OneTimeAutomationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Automation>>,
          List<Automation>,
          Stream<List<Automation>>
        >
    with $FutureModifier<List<Automation>>, $StreamProvider<List<Automation>> {
  OneTimeAutomationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oneTimeAutomationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oneTimeAutomationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Automation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Automation>> create(Ref ref) {
    return oneTimeAutomations(ref);
  }
}

String _$oneTimeAutomationsHash() =>
    r'b468e7bbdff48689de8cc5557ca88d1b68bb0b4e';

@ProviderFor(activeOneTimeAutomations)
final activeOneTimeAutomationsProvider = ActiveOneTimeAutomationsProvider._();

final class ActiveOneTimeAutomationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Automation>>,
          List<Automation>,
          Stream<List<Automation>>
        >
    with $FutureModifier<List<Automation>>, $StreamProvider<List<Automation>> {
  ActiveOneTimeAutomationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeOneTimeAutomationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeOneTimeAutomationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Automation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Automation>> create(Ref ref) {
    return activeOneTimeAutomations(ref);
  }
}

String _$activeOneTimeAutomationsHash() =>
    r'c4292cc8c296dd09f94c997b2dc675c8a9e0cd8f';

@ProviderFor(expiredOneTimeAutomations)
final expiredOneTimeAutomationsProvider = ExpiredOneTimeAutomationsProvider._();

final class ExpiredOneTimeAutomationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Automation>>,
          List<Automation>,
          Stream<List<Automation>>
        >
    with $FutureModifier<List<Automation>>, $StreamProvider<List<Automation>> {
  ExpiredOneTimeAutomationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expiredOneTimeAutomationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expiredOneTimeAutomationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Automation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Automation>> create(Ref ref) {
    return expiredOneTimeAutomations(ref);
  }
}

String _$expiredOneTimeAutomationsHash() =>
    r'efba63b21df6e88ebce86d38be30a115397d0bc2';
