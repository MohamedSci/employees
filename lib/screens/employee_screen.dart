import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:company_employees0/screens/view_data_screen.dart';
import 'package:company_employees0/widgets/emp_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EmployeeScreen extends StatelessWidget {
  String imgUrl;
  final bool isUpdating;

  EmployeeScreen({@required this.isUpdating});

  @override
  Widget build(BuildContext context) {
    EmployeeNotifier employeeNotifier = Provider.of<EmployeeNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 30.0,
        color: Colors.white,
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
                child: EmployeeForm(currentEmployee: employeeNotifier.currentEmployee
                  ,isUpdating: isUpdating,),
            )));
  }
}


