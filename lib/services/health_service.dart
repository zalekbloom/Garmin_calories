import 'package:health/health.dart';

class HealthService {
  final Health _health = Health();

  static final List<HealthDataType> types = [HealthDataType.WORKOUT];

  static final List<HealthDataAccess> permissions = [HealthDataAccess.READ];

  Future<bool> requestPermissions() async {
    return await _health.requestAuthorization(types, permissions: permissions);
  }

  Future<List<HealthDataPoint>> fetchWorkouts(
    DateTime start,
    DateTime end,
  ) async {
    return await _health.getHealthDataFromTypes(
      startTime: start,
      endTime: end,
      types: types,
    );
  }

  void cleanDuplicates(List<HealthDataPoint> data) {
    _health.removeDuplicates(data);
  }
}
