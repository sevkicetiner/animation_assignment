import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/get_loading_progress_usecase.dart';

class LoadingController extends ChangeNotifier {
  final GetLoadingProgressUseCase getLoadingProgressUseCase;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  LoadingController({
    required this.getLoadingProgressUseCase,
  });

  void initializeAnimations(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: AppConstants.animationDuration),
    )..repeat();

    scaleAnimation = Tween<double>(
      begin: AppConstants.scaleBegin,
      end: AppConstants.scaleEnd,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Loading progress'i dinle
    getLoadingProgressUseCase().listen((progress) {
      // Progress değiştiğinde gerekli işlemleri yap
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double get animationValue => animationController.value;
  double get scaleValue => scaleAnimation.value;
} 