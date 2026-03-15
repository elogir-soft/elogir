import 'package:elogir_auto/elogir_auto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'elogir_auto_provider.g.dart';

@Riverpod(keepAlive: true)
ElogirAuto elogirAuto(Ref ref) => throw UnimplementedError(
      'elogirAutoProvider must be overridden at bootstrap',
    );
