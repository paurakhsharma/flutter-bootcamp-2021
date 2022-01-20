import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamrocoffeeadmin/models/user_model.dart';

class UserService {
  Future<List<UserModel>> getUsers() async {
    final usersRef = FirebaseFirestore.instance.collection('users');

    final userDoc = await usersRef.get();

    return userDoc.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
  }
}
