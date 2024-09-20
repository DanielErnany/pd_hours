import 'package:flutter/foundation.dart';
import 'package:pd_hours/models/report.dart';

class ReportsProvider with ChangeNotifier {
  final List<Report> _reports = [];

  List<Report> get reports => [..._reports];

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
