import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/screens/loginpage.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static void login(email, password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Get.snackbar("About User", "User Message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("Account Signed Success"),
          messageText: const Text("Login Success"));
    }).onError((error, stackTrace) {
      print("Err ==> $error");
      Get.snackbar("About User", "User Message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Account SignIn Failed"),
          messageText: Text(error.toString()));
    });
  }

  static void logout() async {
    await _auth.signOut().then((value) {
      Get.snackbar("About User", "User Message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Account Logout Success"),
          messageText: Text("Logout Success"));
      Get.off(LoginPage());
    });
  }

  static Future<bool> storeData(data) async {
    final Colref = FirebaseFirestore.instance.collection('user').doc();
    await Colref.set(data).then((value) {
      print("Success");
      return true;
    }).onError((error, stackTrace) {
      print(error.toString());
      return false;
    });
    return false;
  }

  static Future<String?> register(email, password, data) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user!.uid != null) {
        storeData(data);
        Get.snackbar("About User", "User Message",
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text("Account Creation Success"),
            messageText: Text("Account Created"));

        return credential.user!.uid;
      }
    } catch (e) {
      print("Error=> ${e.toString()}");

      Get.snackbar("About User", "User Message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Account Creation Failed"),
          messageText: Text("Email-Id Already Exists"));

      return null;
    }
  }
}
