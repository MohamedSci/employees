
import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:company_employees0/notifier/auth_notifier.dart';
import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:company_employees0/screens/employee_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EmployeeList extends StatefulWidget {
   EmployeeList({Key key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
String defultImg =  'https://www.google.com.eg/url?sa=i&url=https%3A%2F%2Fwww.vectorstock'
    '.com%2Froyalty-free-vector%2Funknown-person-flat-icon-vector-15222119&'
    'psig=AOvVaw2eRCQs1MnioPjNI-3aug1P&ust=1632847011211000&source=images&cd='
    'vfe&ved=0CAYQjRxqFwoTCPi2_abLn_MCFQAAAAAdAAAAABAJ' ;
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController bdController = TextEditingController();
  TextEditingController hdController = TextEditingController();
  TextEditingController deController = TextEditingController();
  TextEditingController saController = TextEditingController();

  @override
  void initState() {
    EmployeeNotifier employeeNotifier =
    Provider.of<EmployeeNotifier>(context , listen: false);
    getEmployees(employeeNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    EmployeeNotifier employeeNotifier = Provider.of<EmployeeNotifier>(context);

    _onEmployeeDeleted(Employee employee) {
      Navigator.pop(context);
      employeeNotifier.deleteEmployee(employee);
    }
    deleteEmployee(employeeNotifier.currentEmployee, _onEmployeeDeleted);

    Future<void> _refreshList() async {
      getEmployees(employeeNotifier);
    }

    return
       RefreshIndicator(
        child: ListView.separated(
            itemCount: employeeNotifier.employeeList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key("employee"),
                onDismissed: (direction) {
                  employeeNotifier.deleteEmployee(employeeNotifier.currentEmployee);
                  setState(() {
                    employeeNotifier.employeeList.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('one employee dismissed')));
                },
                background: Container(color: Colors.red),
            child:  GestureDetector(child:
               Row(children: [
                Expanded(child: CircleAvatar(backgroundImage: NetworkImage(
              employeeNotifier.employeeList[index].imageFile ?? defultImg,
              ),radius: 60,
              )
              ),
                Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                Text('${employeeNotifier.employeeList[index].fn} ${employeeNotifier.employeeList[index].ln}') ,
                  Text('Hired at: ${employeeNotifier.employeeList[index].hd}'),
                  Text('Work in: ${employeeNotifier.employeeList[index].de}'),
                  Text('Gain :${employeeNotifier.employeeList[index].sa}'),
                ],))
              ],),
                onLongPress: () {
                  employeeNotifier.currentEmployee =
                  employeeNotifier.employeeList[index];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return EmployeeScreen(isUpdating: true,);
                      }
                  ));
                }
            ));},
            separatorBuilder: (BuildContext context, int index) {
            return const Divider(
            color: Colors.black );
                  }
                  ),
       onRefresh: _refreshList,
       );


  }
}


