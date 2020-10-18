import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_graphql_localization_theme_config_template/graph/model/user_model.dart';
import 'package:flutter_graphql_localization_theme_config_template/graph/network/functions.dart';
import 'package:flutter_graphql_localization_theme_config_template/graph/network/user_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  StreamSubscription userAuthSub;

  AuthProvider() {
    userAuthSub = _auth.authStateChanges().listen((newUser) {
      print(
          'AuthProvider - FirebaseAuth - onAuthStateChanged - ${newUser?.uid}');
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub.cancel();
      userAuthSub = null;
    }

    super.dispose();
  }

  bool get isAuthenticated {
    return user != null;
  }

  User get getUser {
    return _auth.currentUser;
  }

  Future<void> signInGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential result = await _auth.signInWithCredential(credential);

    if (result.user != null) {
      User currentUser = result.user;

      await Functions.callEurope(currentUser,
          functionName: "registerUser",
          body: {
            'uid': user.uid,
          });

      currentUser = _auth.currentUser;

      FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

      String token = await _firebaseMessaging.getToken();

      // UserModel userModel = UserModel();
      // userModel.uid = currentUser.uid;
      // userModel.name = currentUser.displayName;
      // userModel.email = currentUser.email;
      // userModel.fcmToken = token;

      // await UserGraph.add(currentUser, userModel: userModel);
    } else {
      throw FirebaseAuthException(message: "result user null");
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
