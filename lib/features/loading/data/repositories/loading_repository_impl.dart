import '../../domain/repositories/loading_repository.dart';

class LoadingRepositoryImpl implements LoadingRepository {
  @override
  Future<void> startLoading() async {
    // Simüle edilmiş loading başlangıcı
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> stopLoading() async {
    // Simüle edilmiş loading bitişi
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Stream<double> getLoadingProgress() {
    // Simüle edilmiş loading progress
    return Stream.periodic(
      const Duration(milliseconds: 100),
      (count) => count / 100,
    ).take(101);
  }
} 