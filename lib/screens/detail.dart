
import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'employee_screen.dart';


class EmployeeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EmployeeNotifier employeeNotifier = Provider.of<EmployeeNotifier>(context);

    _onEmployeeDeleted(Employee employee) {
      Navigator.pop(context);
      employeeNotifier.deleteEmployee(employee);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(employeeNotifier.currentEmployee.fn),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Image.network(
                  employeeNotifier.currentEmployee.imageFile != null
                      ? employeeNotifier.currentEmployee.imageFile :
                "https://p0.pxfuel.com/preview/36/911/727/businessman-man-afraid-angry.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 24),
                Text(
                  '${employeeNotifier.currentEmployee.fn} ${employeeNotifier.currentEmployee.ln}',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                Text(
                  'Department: ${employeeNotifier.currentEmployee.de}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                Text(
                  'Hired at: ${employeeNotifier.currentEmployee.hd}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                Text(
                  'Born at: ${employeeNotifier.currentEmployee.bd}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                Text(
                  'Gain monthly: ${employeeNotifier.currentEmployee.sa}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                // GridView.count(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   padding: EdgeInsets.all(8),
                //   crossAxisCount: 3,
                //   crossAxisSpacing: 4,
                //   mainAxisSpacing: 4,
                //   children: foodNotifier.currentFood.subIngredients
                //       .map(
                //         (ingredient) => Card(
                //           color: Colors.black54,
                //           child: Center(
                //             child: Text(
                //               ingredient,
                //               style: TextStyle(color: Colors.white, fontSize: 16),
                //             ),
                //           ),
                //         ),
                //       )
                //       .toList(),
                // )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return EmployeeScreen(
                    isUpdating: true,
                  );
                }),
              );
            },
            child: Icon(Icons.edit),
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () => deleteEmployee(employeeNotifier.currentEmployee, _onEmployeeDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
