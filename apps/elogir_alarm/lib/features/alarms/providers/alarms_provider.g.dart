// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(alarms)
final alarmsProvider = AlarmsProvider._();

final class AlarmsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Alarm>>,
          List<Alarm>,
          Stream<List<Alarm>>
        >
    with $FutureModifier<List<Alarm>>, $StreamProvider<List<Alarm>> {
  AlarmsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmsHash();

  @$internal
  @override
  $StreamProviderElement<List<Alarm>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Alarm>> create(Ref ref) {
    return alarms(ref);
  }
}

String _$alarmsHash() => r'e94f2a836edb412f995d88d3312f952111ed845d';

@ProviderFor(enabledAlarms)
final enabledAlarmsProvider = EnabledAlarmsProvider._();

final class EnabledAlarmsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Alarm>>,
          List<Alarm>,
          Stream<List<Alarm>>
        >
    with $FutureModifier<List<Alarm>>, $StreamProvider<List<Alarm>> {
  EnabledAlarmsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enabledAlarmsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enabledAlarmsHash();

  @$internal
  @override
  $StreamProviderElement<List<Alarm>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Alarm>> create(Ref ref) {
    return enabledAlarms(ref);
  }
}

String _$enabledAlarmsHash() => r'6a14e262bfe859b6bc386f2e374c3b0917323021';
