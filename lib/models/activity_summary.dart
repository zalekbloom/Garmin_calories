class ActivitySummary {
  int hikingActivities;
  int swimmingActivities;

  double hikingCalories;
  double swimmingCalories;

  ActivitySummary({
    this.hikingActivities = 0,
    this.swimmingActivities = 0,
    this.hikingCalories = 0,
    this.swimmingCalories = 0,
  });

  double get totalCalories => hikingCalories + swimmingCalories;
}
