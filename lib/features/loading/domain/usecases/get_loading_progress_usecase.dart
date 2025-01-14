import '../repositories/loading_repository.dart';

class GetLoadingProgressUseCase {
  final LoadingRepository repository;

  GetLoadingProgressUseCase(this.repository);

  Stream<double> call() {
    return repository.getLoadingProgress();
  }
} 