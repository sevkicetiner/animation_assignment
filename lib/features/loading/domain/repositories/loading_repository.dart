abstract class LoadingRepository {
  Future<void> startLoading();
  Future<void> stopLoading();
  Stream<double> getLoadingProgress();
} 