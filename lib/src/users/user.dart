import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;

  UserModel({
    this.uid = '',
    this.name = '',
    this.email = '',
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
