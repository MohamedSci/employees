
import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:company_employees0/api/states.dart';
import 'package:company_employees0/screens/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshList() async {
      Apis.get(context).getEmployees();
    }

    return BlocConsumer<Apis, ChangeState>(
    listener: (context, state) {
    print(state);
    },
    builder: (context, state) {
      print(state);
      print(" bloc Consumer works");

      return Expanded(
          child: RefreshIndicator(

            child: FutureBuilder<List<Employee>>(
                future: Apis.get(context).getEmployees(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return RefreshProgressIndicator();
                  }
                  if (snapshot.connectionState != ConnectionState.done) {
                    return SizedBox();
                  }
                  final employees = snapshot.data;
                  return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      itemCount: employees?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        Employee employee = employees[index];
                        return Dismissible(
                            key: Key("employees"),
                            onDismissed: (direction) {
                              Apis.get(context).deleteEmployee(employee);
                              setState(() {
                                employees.remove(employee);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('$employee dismissed')));
                            },
                            background: Container(color: Colors.red),
                            child: GestureDetector(child:
                            Row(children: [
                              Expanded(child: CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                  employee.imageFile ?? defultImg,
                                ),
                                radius: 60,
                              )
                              ),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('${employee.fn} ${employee.ln}'),
                                      Text('Hired at: ${employee.hd}'),
                                      Text('Work in: ${employee.de}'),
                                      Text('Gain :${employee.sa}'),
                                    ],))
                            ],),
                                onDoubleTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return EmployeeDetail(employee);
                                      }
                                  ));
                                }
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                            color: Colors.black);
                      }
                  );
                }),
            onRefresh: _refreshList,
            // )
          ));
    });
  }
}


