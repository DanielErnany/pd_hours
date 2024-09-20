class Report {
  int? id;
  int employeeId;
  String description;
  int spentHours;
  DateTime createdAt;

  Report({
    this.id,
    required this.employeeId,
    required this.description,
    required this.spentHours,
    required this.createdAt,
  });
}
