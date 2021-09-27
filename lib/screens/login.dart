
import 'package:company_employees0/Model/user_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:company_employees0/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'employee_screen.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController =  TextEditingController();
  AuthMode _authMode = AuthMode.Login;

   UserAccount _account ;

  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState.validate()) { return ; }
    _formKey.currentState.save();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    if (_authMode == AuthMode.Login) {
     await login(_account, authNotifier);

     Navigator.push(context, MaterialPageRoute(builder:
         (context) =>  EmployeeScreen(),));

    } else {
      signup(_account, authNotifier);
      setState(() {
           _authMode = AuthMode.Login;
      });
    }
  }

  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Display Name",
        labelStyle: TextStyle(color: Colors.white),
      ),
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Display Name is required';
        }
        if (value.length < 5 || value.length > 12) {
          return 'Display Name must be betweem 5 and 12 characters';
        }
        return null;
      },
      onSaved: (String value) {
        _account.name = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white54),
      ),
      keyboardType: TextInputType.emailAddress,
      initialValue: 'julian@gmail.com',
      style: const TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (String value) {
        _account.mail = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: const TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 5 || value.length > 20) {
          return 'Password must be betweem 5 and 20 characters';
        }

        return null;
      },
      onSaved: (String value) {
        _account.pass = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: const TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building login screen");

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        decoration: const BoxDecoration(color: Colors.green),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 96, 32, 0),
              child: Column(
                children: <Widget>[
                    Text( _authMode == AuthMode.Login ?
                    "Sign In" : "Register",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 32),
                  _authMode == AuthMode.Signup ? _buildDisplayNameField() : const SizedBox(),
                  _buildEmailField(),
                  _buildPasswordField(),
                  _authMode == AuthMode.Signup ? _buildConfirmPasswordField() : const SizedBox(),
                  const SizedBox(height: 48),
                  ButtonTheme(
                    minWidth: 200,
                    child: TextButton(
                      child: Text(_authMode == AuthMode.Login ?
                         "Aren't have Account yet?"
                            : "Let's Sign in !",
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _authMode =
                              _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ButtonTheme(
                    minWidth: 200,
                    child: ElevatedButton(
                      onPressed: () => _submitForm(),
                      child: Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Signup',
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
