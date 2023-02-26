import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:internship_project/screens/dashboard.dart';
import 'package:internship_project/screens/loginpage.dart';

class DataController extends GetxController {
  static DataController controller = Get.find();
  late Rx<User?> user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Initialize");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    user = Rx<User?>(FirebaseAuth.instance.currentUser);
    user.bindStream(FirebaseAuth.instance.userChanges());
    ever(user, (User? user) {
      if (user == null) {
        Get.off(LoginPage());
      } else {
        Get.off(dashboard());
        print("Welcome PAge ${user.uid}");
      }
    });
  }
}
