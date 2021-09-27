class UserAccount {
String id;
String mail;
String pass;
String name ;
String imageFile;

UserAccount({ this.id ,this.name ,this.imageFile, this.mail, this.pass});

UserAccount.fromJSON(Map<String , dynamic> json){
  id = json["id"];
  mail = json['mail'];
  pass = json['pass'];
  name = json['name'];
imageFile = json['imageFile'];
}

Map<String,dynamic> toMap() {
  return {
    'id': id,
    'mail':mail,
    'pass':pass,
    'imageFile': imageFile,
    'name':name,
      };
}
}