import 'package:elogir_home/features/setup/services/credentials_service.dart';
import 'package:elogir_home/shared/providers/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credentials_service_provider.g.dart';

@Riverpod(keepAlive: true)
CredentialsService credentialsService(Ref ref) {
  return CredentialsService(ref.watch(secureStorageProvider));
}
