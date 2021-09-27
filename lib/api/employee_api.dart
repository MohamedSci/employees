import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_employees0/Model/emp_model.dart';
import 'package:company_employees0/Model/user_model.dart';
import 'package:company_employees0/notifier/auth_notifier.dart';
import 'package:company_employees0/notifier/employee_notifier.dart';
import 'package:company_employees0/screens/employee_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

login(UserAccount account , AuthNotifier authNotifier) async {
  UserCredential authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: account.mail, password: account.pass)
      .catchError((error) => print(error.code));
  if (authResult != null) {
    User firebaseUser = authResult.user;
    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(UserAccount account, AuthNotifier authNotifier) async {
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
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));
  authNotifier.setUser(null);
}


initializeCurrentUser(AuthNotifier authNotifier) async {
  User firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getEmployees(EmployeeNotifier employeeNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('employees')
      // .orderBy("hire_date", descending: true)
      .get();
  List<Employee> _employeeList = [];
  snapshot.docs.forEach((document) {
    Employee employee = Employee.fromJSON(document.data());
    _employeeList.add(employee);
  });
  employeeNotifier.employeeList = _employeeList;
}

uploadEmployeeAndImage(Employee employee, bool isUpdating, File localFile,
    Function employeeUploaded) async {
  if (localFile != null) {
    print("uploading image");
    var fileExtension = path.extension(localFile.path);
    print(fileExtension);
    var uuid = const Uuid().v4();
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('foods/images/$uuid$fileExtension');
    await firebaseStorageRef.putFile(localFile).catchError((onError) {
      print(onError);
      return false;
    });
    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadEmployee(employee, isUpdating, employeeUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
  }
}

_uploadEmployee(Employee employee, bool isUpdating, Function employeeUploaded, {String imageUrl}) async {
  CollectionReference foodRef = FirebaseFirestore.instance.collection('employees');
  print(isUpdating);
  if (imageUrl != null) { employee.imageFile = imageUrl; }
  if (isUpdating == true) {
    await foodRef.doc(employee.id).update(employee.toMap());
    employeeUploaded(employee);
    print('updated food with id: ${employee.id}');
  } else {
    // food.createdAt = Timestamp.now();
    DocumentReference documentRef = await foodRef.add(employee.toMap());
    employee.id = documentRef.id;
    print('uploaded food successfully: ${employee.toString()}');
    await documentRef.set(employee.toMap(), );
    employeeUploaded(employee);
  }
}

deleteEmployee(Employee employee, Function employeeDeleted) async {
  if (employee.imageFile != null) {
    Reference storageReference =
        FirebaseStorage.instance.refFromURL(employee.imageFile);
    print(storageReference.fullPath);
    await storageReference.delete();
    print('image deleted');
  }
  await FirebaseFirestore.instance.collection('Foods').doc(employee.id).delete();
  employeeDeleted(employee);
}

