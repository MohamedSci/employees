import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:company_employees0/screens/view_data_screen.dart';
import 'package:company_employees0/widgets/emp_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EmployeeScreen extends StatelessWidget {
  String imgUrl;
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 30.0,
        color: Colors.amber,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const EmployeeListScreen()),
          );
        },
      ),
      title: const Text(
        'Employees',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.0,

    ),
        body: Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            decoration: const BoxDecoration(color: Colors.green),
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: EmployeeForm(),
            )));
  }
}


