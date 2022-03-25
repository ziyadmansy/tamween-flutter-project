import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/auth_controller.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/home_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/login_screen.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

import 'vendor/vendor_home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> loginSavedUsers() async {
    final authController = Get.find<AuthController>();

    await authController.checkLogin();
    bool isLoggedIn = authController.isAuth();

    if (isLoggedIn) {
      // User is already Logged in
      Future.delayed(
        Duration.zero,
        () async {
          if (authController.userType.value == 2) {
            Get.offNamed(VendorHomeScreen.routeName);
          } else {
            Get.offNamed(HomeScreen.routeName);
          }
        },
      );
    } else {
      // Guest User
      Future.delayed(
        Duration(seconds: 1),
        () async {
          Get.offNamed(LoginScreen.routeName);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loginSavedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
