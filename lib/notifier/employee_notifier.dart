import 'dart:collection';

import 'package:company_employees0/Model/emp_model.dart';
import 'package:flutter/cupertino.dart';

class EmployeeNotifier with ChangeNotifier {
  List<Employee> _employeeList = [];
  Employee _currentEmployee;

  UnmodifiableListView<Employee> get employeeList => UnmodifiableListView(_employeeList);
  Employee get currentEmployee => _currentEmployee;

  set employeeList(List<Employee> employeeList) {
    _employeeList = employeeList;
    notifyListeners();
  }

  set currentEmployee(Employee employee) {
    _currentEmployee = employee;
    notifyListeners();
  }


  addEmployee(Employee employee) {
    _employeeList.insert(0, employee);
    notifyListeners();
  }

  deleteEmployee(Employee employee) {
    _employeeList.removeWhere((_employee) => _employee.id == employee.id);
    notifyListeners();
  }
}
