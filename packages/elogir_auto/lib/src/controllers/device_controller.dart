abstract class DeviceController<T> {
  Stream<T> get stateStream;
  T? get currentState;
  Future<void> connect();
  Future<void> disconnect();
  Future<T> refresh();
}
