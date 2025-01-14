class LoadingConfig {
  final int segmentCount;
  final double segmentWidth;
  final double segmentHeight;
  final double gapAngle;
  final double circleRadius;
  final double glowIntensity;

  const LoadingConfig({
    this.segmentCount = 8,
    this.segmentWidth = 25.0,
    this.segmentHeight = 35.0,
    this.gapAngle = 3.2,
    this.circleRadius = 120.0,
    this.glowIntensity = 0.3,
  });
} 