
import 'package:company_employees0/widgets/emp_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
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
