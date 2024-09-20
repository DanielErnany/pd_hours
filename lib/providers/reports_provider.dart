import 'package:flutter/foundation.dart';
import 'package:pd_hours/models/report.dart';

class ReportsProvider with ChangeNotifier {
  final List<Report> _reports = [];

  List<Report> get reports => [..._reports];

  List<Report> reportsFromEmployees({
    required List<int> employeesIds,
    required DateTime initialDate,
    required DateTime finalDate,
  }) {
    List<Report> reportsFromEmployees = _reports.where((report) {
      return employeesIds.contains(report.employeeId) &&
          report.createdAt.isAfter(initialDate) &&
          report.createdAt.isBefore(finalDate);
    }).toList();

    return reportsFromEmployees;
  }

  void addReport(Report report) {
    int maxId = _reports.isEmpty
        ? 0
        : _reports.map((squad) => squad.id).reduce((a, b) => a! > b! ? a : b)!;

    int nextId = maxId + 1;

    report.id = nextId;

    _reports.add(report);

    notifyListeners();
  }
}
