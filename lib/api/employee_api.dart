import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/Model/user_model.dart';
import 'package:company_employees0/api/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
class Apis extends Cubit <ChangeState> {
  Apis() : super(InitialState());
  static Apis get(context) => BlocProvider.of(context);

  login(UserAccount account ) async {
    UserCredential authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: account.mail, password: account.pass)
        .catchError((error) => print(error.code));
    if (authResult != null) {
      User firebaseUser = authResult.user;
      if (firebaseUser != null) {
        print("Log In: $firebaseUser");
        emit(SignInState());
      }
    }
    Fluttertoast.showToast(
        msg: "Signed in !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  signup(UserAccount account) async {
    UserCredential authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: account.mail, password: account.pass)
        .catchError((error) => print(error.code));
    if (authResult != null) {
      // UserUpdateInfo updateInfo = UserUpdateInfo();
      // var displayName =
      // updateInfo.displayName = user.displayName;
      User user = authResult.user;
      if (user != null) {
        await FirebaseAuth.instance.currentUser.
        updateProfile(displayName:user.displayName);
        // await firebaseUser.updateProfile(updateInfo);
        // await User.reload();
        print("Sign up: $User");
        User currentUser = FirebaseAuth.instance.currentUser;
        emit(SignUpState());
      }
    }
    Fluttertoast.showToast(
        msg: "Registered !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  signout() async {
    await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));
    emit(SignOutState());
    Fluttertoast.showToast(
        msg: "Bye !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  initializeCurrentUser() async {
    User firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      print(firebaseUser);
      emit(IntializeCurrentState());
    }
  }

  Future <List<Employee>> getEmployees() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('employees')
    // .orderBy("hire_date", descending: true)
        .get();
    List<Employee> _employeeList = [];
    snapshot.docs.forEach((document) {
      Employee employee = Employee.fromJSON(document.data());
      _employeeList.add(employee);
    });
    Fluttertoast.showToast(
        msg: "Awesome !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return _employeeList;
  }

  uploadEmployeeAndImage(Employee employee, bool isUpdating, File localFile) async {
    if (localFile != null) {
      print("uploading image");
      var fileExtension = path.extension(localFile.path);
      print(fileExtension);
      var uuid = const Uuid().v4();
      final Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('Employees/images/$uuid$fileExtension');
      await firebaseStorageRef.putFile(localFile).catchError((onError) {
        print(onError);
        return false;
      });
      String url = await firebaseStorageRef.getDownloadURL();
      print("download url: $url");
      _uploadEmployee(employee, isUpdating, imageUrl: url);
    } else {
      print('...skipping image upload');
    }
  }

  _uploadEmployee(Employee employee, bool isUpdating, {String imageUrl}) async {
    CollectionReference employeeRef = FirebaseFirestore.instance
        .collection('employees');
    print(isUpdating);
    if (imageUrl != null) { employee.imageFile = imageUrl;
    if (isUpdating == true) {
      await employeeRef.doc(employee.id).update(employee.toMap());
      print('updated employee with id: ${employee.id}');
      emit(UpdateState());
    } else {
      DocumentReference documentRef = await employeeRef.add(employee.toMap());
      employee.id = documentRef.id;
      print('uploaded employee successfully: ${employee.toString()}');
      await documentRef.set(employee.toMap(), );
      emit(AddState());
    }
    }else{
      if (isUpdating == true) {
        await employeeRef.doc(employee.id).update(employee.toMap());
        print('updated employee with id: ${employee.id}');
        emit(UpdateState());
      } else {
        DocumentReference documentRef = await employeeRef.add(employee.toMap());
        employee.id = documentRef.id;
        print('uploaded employee successfully: ${employee.toString()}');
        await documentRef.set(employee.toMap(), );
        emit(AddState());
      }
    }
    Fluttertoast.showToast(
        msg: "Awesome !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  deleteEmployee(Employee employee,) async {
    if (employee.imageFile != null) {
      Reference storageReference =
      FirebaseStorage.instance.refFromURL(employee.imageFile);
      print(storageReference.fullPath);
      await storageReference.delete();
      print('image deleted');
    }
    await FirebaseFirestore.instance.collection('employees').doc(employee.id).delete();
    emit(DeleteState());
    Fluttertoast.showToast(
        msg: "Awesome !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


}
