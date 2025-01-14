import 'package:animation_assigment/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'analysis_icon.dart';

class LoadingImageContainer extends StatefulWidget {
  const LoadingImageContainer({super.key});

  @override
  State<LoadingImageContainer> createState() => _LoadingImageContainerState();
}

class _LoadingImageContainerState extends State<LoadingImageContainer> {
  late Offset _targetOffset;
  late Offset _currentOffset;

  @override
  void initState() {
    super.initState();
    _currentOffset = _getRandomOffset();
    _targetOffset = _getRandomOffset();
  }

  Offset _getRandomOffset() {
    final random = math.Random();
    return Offset(
      random.nextDouble() * 2 - 1,
      random.nextDouble() * 2 - 1,
    );
  }

  void _updateTarget() {
    setState(() {
      _currentOffset = _targetOffset;
      _targetOffset = _getRandomOffset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/example_house.jpeg',
                width: 240,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: _currentOffset,
              end: _targetOffset,
            ),
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOut,
            builder: (context, Offset offset, child) {
              return Transform.translate(
                offset: Offset(
                  offset.dx * 80,
                  offset.dy * 80,
                ),
                child: const AnalysisIcon(
                  size: 10, // Boyutu 10'dan 5'e düşürdüm
                  color: Color.fromARGB(255, 3, 187, 163),
                ),
              );
            },
            onEnd: _updateTarget,
          ),
        ),
      ],
    );
  }
} 