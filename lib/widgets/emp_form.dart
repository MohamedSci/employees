import 'dart:io';

import 'package:company_employees0/screens/employee_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
final GlobalKey <FormState> _formKey = GlobalKey<FormState>();
  String _imageUrl ="";
  File _imageFile ;
TextEditingController fnController = TextEditingController();
TextEditingController lnController = TextEditingController();
TextEditingController bdController = TextEditingController();
TextEditingController hdController = TextEditingController();
TextEditingController deController = TextEditingController();
TextEditingController saController = TextEditingController();
reset() {
  fnController.text = "";
  lnController.text = "";
  bdController.text = "";
  hdController.text = "";
  deController.text = "";
  saController.text = "";
}


_showImage() {
  if (_imageFile == null && _imageUrl == null) {
    return ButtonTheme(
      child: ElevatedButton(
        onPressed: () => _getLocalImage(),
        child: const Text(
          'Add Image',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  } else if (_imageFile != null) {
    print('showing image from local file');
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Image.file(
          _imageFile,
          fit: BoxFit.cover,
          height: 250,
        ),
        FlatButton(
          padding: const EdgeInsets.all(16),
          color: Colors.black54,
          child: const Text(
            'Change Image',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
          ),
          onPressed: () => _getLocalImage(),
        )
      ],
    );
  } else if (_imageUrl != null) {
    print('showing image from url');

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Image.network(
          _imageUrl,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          height: 250,
        ),
        FlatButton(
          padding: const EdgeInsets.all(16),
          color: Colors.black54,
          child: const Text(
            'Change Image',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
          ),
          onPressed: () => _getLocalImage(),
        )
      ],
    );
  }
}

_getLocalImage() async {
  XFile imageFile =
  await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);
  if (imageFile != null) {
    setState(() {
      _imageFile = File(imageFile.path);
    });
  }
}

  @override
  void initState() {
    BlocProvider.of<Apis>(context, listen: false);

    super.initState(); }

_saveEmployee() async {
  // await FirebaseAuth.instance.signInAnonymously();
  print('saveFood Called');
  if (!_formKey.currentState.validate()) {
    return;
  }
  _formKey.currentState.save();
  print('form saved');
  Employee currentEmployee = Employee(
      fn: fnController.text , ln: lnController.text,
      bd:bdController.text , hd: hdController.text,
      de: deController.text , sa:saController.text );

  Apis.get(context).
  uploadEmployeeAndImage(currentEmployee, false, _imageFile);
 }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
      child:
      Column(children: <Widget>[
        const SizedBox(height: 6),
        _showImage(),
        const SizedBox(height: 16),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  "First Name :",
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
                   controller: fnController,
                  decoration: const InputDecoration(labelText: ''),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  "Last Name :",
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
                  controller: lnController,
                  decoration: const InputDecoration(labelText: ''),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  "Birth Date :",
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
                  controller: bdController,
                  decoration: const InputDecoration(labelText: ''),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  "Hire Date :",
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
                  controller: hdController,
                  decoration: const InputDecoration(labelText: ''),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  "Department:",
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
                  controller: deController,
                  decoration: const InputDecoration(labelText: ''),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  "Salary :",
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
                  controller: saController,
                  decoration: const InputDecoration(labelText: ''),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
            onPressed: () {
    FocusScope.of(context).requestFocus(FocusNode());
    _saveEmployee();
    },
    child: const Icon(Icons.save , color: Colors.amber,),
    foregroundColor: Colors.white,
                  ),
              ElevatedButton(
                child: const Text("reset"),
                onPressed: reset,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
