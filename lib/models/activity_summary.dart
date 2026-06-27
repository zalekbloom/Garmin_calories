class ActivitySummary {
  int hikingCount;
  int swimmingCount;

  double hikingCalories;
  double swimmingCalories;

  ActivitySummary({
    this.hikingCount = 0,
    this.swimmingCount = 0,
    this.hikingCalories = 0,
    this.swimmingCalories = 0,
  });

  double get totalCalories => hikingCalories + swimmingCalories;
}
