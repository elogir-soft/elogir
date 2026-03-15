// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_results_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scanResults)
final scanResultsProvider = ScanResultsProvider._();

final class ScanResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ScanResult>>,
          List<ScanResult>,
          FutureOr<List<ScanResult>>
        >
    with $FutureModifier<List<ScanResult>>, $FutureProvider<List<ScanResult>> {
  ScanResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<ScanResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ScanResult>> create(Ref ref) {
    return scanResults(ref);
  }
}

String _$scanResultsHash() => r'408d65635eec6d38feda7bcb7b0d7446cfd7c676';
