import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lead_management_system/src/users/user.dart';
import 'package:lead_management_system/utils/firebase_collections.dart';

class UserServices {
  Future<List<UserModel>> getAllUsers() async => usersCollection.get().then(
        (result) {
          List<UserModel> users = [];
          for (DocumentSnapshot user in result.docs) {
            users.add(UserModel.fromSnapshot(user));
          }
          return users;
        },
      );
}
