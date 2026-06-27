import 'package:health/health.dart';

enum ActivityKind { hiking, swimming, other }

class ActivityClassifier {
  static ActivityKind classify(HealthWorkoutActivityType type) {
    switch (type) {
      case HealthWorkoutActivityType.HIKING:
        return ActivityKind.hiking;

      case HealthWorkoutActivityType.SWIMMING_POOL:
      case HealthWorkoutActivityType.SWIMMING_OPEN_WATER:
        return ActivityKind.swimming;

      default:
        return ActivityKind.other;
    }
  }
}
