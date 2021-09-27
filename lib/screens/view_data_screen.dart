
import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:company_employees0/widgets/emp_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'employee_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    Provider.of<EmployeeNotifier>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.green),
        child:  EmployeeList(),
      ),
    );
  }
}
