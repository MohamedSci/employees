import 'package:company_employees0/Model/user_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:company_employees0/api/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employee_screen.dart';

enum AuthMode { signup, login }

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  AuthMode _authMode = AuthMode.login;
  String name, mail, pass, copass;
  TextEditingController passController,
      copassController = TextEditingController();
  resetPass() {
    passController.text = "";
    copassController.text = "";
  }

  @override
  void initState() {
    BlocProvider.of<Apis>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserAccount account = UserAccount();
    return BlocConsumer<Apis , ChangeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            decoration: const BoxDecoration(color: Colors.green),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 90,
                    ),
                    Text(
                      _authMode == AuthMode.login ? "Sign In" : "Sign Up",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 46,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 40),
                    _authMode == AuthMode.signup
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "name :",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.amber,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            decoration:
                            const InputDecoration(labelText: ''),
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700),
                            onSaved: (newValue) => account.name = newValue,
                            validator: (value) {
                              if (value == "") {
                                return 'name is required';
                              }
                            },
                          ),
                        ),
                      ],
                    )
                        : const SizedBox(height: 5),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "Email :",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.amber,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(labelText: ''),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700),
                              onSaved: (newValue) => account.mail = newValue,
                              validator: (value) {
                                value == "" ? 'Email is required' : '';
                              },
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "Password :",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.amber,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(labelText: ''),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700),
                              onSaved: (newValue) => account.pass = newValue,
                              validator: (value) {
                                if (value == "") {
                                  return 'Password is required';
                                }
                                ;
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _authMode == AuthMode.signup
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "Confirm Password :",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.amber,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: copassController,
                              obscureText: true,
                              decoration:
                              const InputDecoration(labelText: ''),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700),
                              onSaved: (newValue) => copass = newValue,
                              validator: (value) {
                                if (value == "") {
                                  return 'Password Confirmation is required';
                                }
                              }),
                        ),
                      ],
                    )
                        : const SizedBox(height: 10),
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        _authMode == AuthMode.login
                            ? ElevatedButton(
                          onPressed: () async {
                            await Apis.get(context).login(account);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                   EmployeeScreen(),
                                ));
                          },
                          child: const Text(
                            "Log in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.amber,
                              fontSize: 18,
                            ),
                          ),
                        )
                            : ElevatedButton(
                          onPressed: () {
                            account.pass == copass
                                ? Apis.get(context)
                                .signup(account)
                                : resetPass();
                            _authMode = AuthMode.login;
                            Apis.get(context).emit(SignInState());
                          },
                          child: const Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.amber,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _authMode == AuthMode.login
                            ? TextButton(
                          onPressed: () {
                            _authMode = AuthMode.signup;
                            Apis.get(context).emit(SignUpState());
                          },
                          child: const Text(
                            "Are you have not account yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        )
                            : TextButton(
                          onPressed: () {
                            _authMode = AuthMode.login;
                            Apis.get(context).emit(SignInState());
                          },
                          child: const Text(
                            "Already Have Account ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
