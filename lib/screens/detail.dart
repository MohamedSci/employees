
import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:company_employees0/widgets/emp_dialoge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class EmployeeDetail extends StatelessWidget {
Employee _employee;
EmployeeDetail(this._employee);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(_employee.de),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Image.network(
                  _employee.imageFile != null
                      ?_employee.imageFile :
                "https://p0.pxfuel.com/preview/36/911/727/businessman-man-afraid-angry.jpg",
                  errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                    return Text('Loading...');
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 24),
                Text(
                  '${_employee.fn} ${_employee.ln}',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  '${_employee.ln}',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  'Department: ${_employee.de}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                Text(
                  'Hired at: ${_employee.hd}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                Text(
                  'Born at: ${_employee.bd}',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                Text(
                  'Gain monthly: ${_employee.sa}',
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
                MaterialPageRoute(
                      builder: (BuildContext context) =>
                    EmployeeDialoge(_employee),
                ),
              );
            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: ()  {
              Apis.get(context).deleteEmployee(_employee);
                            Navigator.pop(context);},
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
