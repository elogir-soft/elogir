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
        isAutoDispose: false,
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

String _$alarmsHash() => r'33cb5c9aec9225dbed65af616c4e22df4b7221cf';

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
        isAutoDispose: false,
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

String _$enabledAlarmsHash() => r'2b40667c006cbb5aef02a305867916951f9a5ef7';
