import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/api/employee_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeDialoge extends StatefulWidget {
  Employee currentEmployee = Employee();
  EmployeeDialoge(this.currentEmployee);
  @override
   _EmployeeDialogeState createState() => _EmployeeDialogeState();
}

class _EmployeeDialogeState extends State<EmployeeDialoge> {
final GlobalKey <FormState> _formKey = GlobalKey<FormState>();
  File _imageFile;
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
  String _imageUrl = widget.currentEmployee.imageFile;
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
          color: Colors.tealAccent,
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
          errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
            return Text('Loading...');
          },
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

_updateEmployee() {
  print('Update Called');
  Employee employee = Employee(id: widget.currentEmployee.id,
      fn: fnController.text,ln: lnController.text,
      bd:bdController.text,hd: hdController.text,
      de: deController.text,sa:saController.text ,
      imageFile: widget.currentEmployee.imageFile);
  Apis.get(context).uploadEmployeeAndImage(employee, true, _imageFile);
  print('Dialoge updated');
  Fluttertoast.showToast(
      msg: "Awesome !",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.amberAccent,
      textColor: Colors.white,
      fontSize: 16.0
  );
Navigator.pop(context);
}


  @override
  void initState() {
        super.initState(); }


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(child:
      AlertDialog(
      key: _formKey,
      content:
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
                _updateEmployee();
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
    ));
  }
}


