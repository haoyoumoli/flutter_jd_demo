import 'dart:math' as Math;

///值的范围
class ValueRange {
  const ValueRange({required this.min, required this.max});

  final double min;
  final double max;

  ///progress 必须在0~1之间
  double progressedValue(double progress) {
    progress = Math.min(Math.max(progress, 0.0),1.0);
    return min + (max - min) * progress;
  }
}
