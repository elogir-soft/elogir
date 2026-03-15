import 'package:elogir_auto/elogir_auto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_database_provider.g.dart';

@Riverpod(keepAlive: true)
AutoDatabase autoDatabase(Ref ref) => throw UnimplementedError(
      'autoDatabaseProvider must be overridden at bootstrap',
    );
