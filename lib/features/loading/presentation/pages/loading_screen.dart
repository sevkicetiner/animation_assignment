import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/repositories/loading_repository_impl.dart';
import '../../domain/usecases/get_loading_progress_usecase.dart';
import '../controllers/loading_controller.dart';
import '../widgets/circular_loading_painter.dart';
import '../widgets/segment_loader_painter.dart';
import '../widgets/loading_image_container.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final LoadingController _controller;

  @override
  void initState() {
    super.initState();
    final repository = LoadingRepositoryImpl();
    final useCase = GetLoadingProgressUseCase(repository);
    _controller = LoadingController(getLoadingProgressUseCase: useCase)..initializeAnimations(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Katman 1: Arka plan gradyanı ve animasyonlar
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                colors: [
                  AppColors.white,
                  AppColors.primaryWithOpacity(0.9),
                  AppColors.grey,
                ],
                radius: 2.0,
                stops: const [0.1, 0.9, 0.1],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: AnimatedBuilder(
                animation: _controller.animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CircularLoadingPainter(
                      animationValue: _controller.animationValue,
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: AnimatedBuilder(
                animation: _controller.animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SegmentLoaderPainter(
                      animationValue: _controller.animationValue,
                    ),
                  );
                },
              ),
            ),
          ),

          // Katman 2: Orta kısımdaki görsel
          Positioned(
            bottom: 150,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: LoadingImageContainer(),
          ),

          // Katman 3: Loading yazısı ve progress bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryWithOpacity(0.7),
                    ],
                  ).createShader(bounds),
                  child: const Text(
                   "Analyzing", //AppConstants.loadingText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: _controller.animationValue,
                      minHeight: 20,
                      backgroundColor: AppColors.greyWithOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 