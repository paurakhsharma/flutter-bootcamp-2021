import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hamrocoffee/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        currentUser = null;
        notifyListeners();
      } else {
        _initUser(user);
      }
    });
  }

  Future<void> _initUser(User user) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      print('user logged in');
      currentUser = UserModel.fromSnapshot(userSnapshot);
      notifyListeners();
      return;
    }

    currentUser = UserModel(
      email: user.email ?? '',
      id: user.uid,
      name: user.displayName ?? '',
      orders: [],
    );

    notifyListeners();

    await userRef.set(currentUser!.toMap());
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
