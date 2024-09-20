import 'package:flutter/foundation.dart';
import 'package:pd_hours/models/employee.dart';

class EmployeesProvider with ChangeNotifier {
  final List<Employee> _employees = [];

  List<Employee> get employees => [..._employees];

  List<Employee> employeesFromSquad(int squadId) {
    List<Employee> employeesFromSquad = _employees
        .where(
          (element) => element.squadId == squadId,
        )
        .toList();

    return employeesFromSquad;
  }

  void addEmployee(Employee employee) {
    int maxId = _employees.isEmpty
        ? 0
        : _employees
            .map((squad) => squad.id)
            .reduce((a, b) => a! > b! ? a : b)!;

    int nextId = maxId + 1;

    employee.id = nextId;

    _employees.add(employee);

    notifyListeners();
  }
}
