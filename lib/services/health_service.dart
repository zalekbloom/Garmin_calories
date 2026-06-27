import 'package:health/health.dart';

class HealthService {
  final Health _health = Health();

  final List<HealthDataType> types = [HealthDataType.WORKOUT];

  Future<bool> requestPermissions() async {
    return await _health.requestAuthorization(types);
  }

  Future<List<HealthDataPoint>> fetchWorkouts(
    DateTime start,
    DateTime end,
  ) async {
    final data = await _health.getHealthDataFromTypes(
      startTime: start,
      endTime: end,
      types: types,
    );

    _health.removeDuplicates(data);
    return data;
  }
}
