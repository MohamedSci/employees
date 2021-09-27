import 'package:image_picker/image_picker.dart';

class Employee {
String id;
String mail;
String pass;
String fn ;
String ln;
String hd;
String bd;
String de;
String sa;
String imageFile;
Employee({ this.id ,this.fn , this.ln ,this.hd, this.bd, this.de , this.sa,
  this.imageFile, this.mail, this.pass});
Employee.fromJSON(Map<String , dynamic> json){
  id = json["id"];
  mail = json['mail'];
  pass = json['pass'];
  fn = json['first_name'];
  ln = json['last_name'];
 hd = json['birth_date'];
 hd = json['hire_date'];
de = json['department'];
sa = json['salary'];
imageFile = json['imageFile'];
}
Map<String,dynamic> toMap() {
  return {
    'id': id,
    'mail':mail,
    'pass':pass,
    'imageFile': imageFile,
    'first_name':fn,
    'last_name' : ln,
    'birth_date': bd,
    'hire_data':hd,
    'department':de,
    'salary':sa,
  };
}
}