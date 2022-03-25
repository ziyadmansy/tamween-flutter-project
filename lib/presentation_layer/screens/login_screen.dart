import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/auth_controller.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/signup_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/vendor_home_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendors_page.dart';
import 'package:tamween_flutter_project/shared/shared_widgets.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool isObscure = true;

  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final isValid = formKey.currentState?.validate();
    if (isValid ?? false) {
      FocusScope.of(context).unfocus();

      try {
        setState(() {
          _isLoading = true;
        });
        await authController.loginUser(
          emailController.text,
          passwordController.text,
        );
        setState(() {
          _isLoading = false;
        });
        if (authController.userType.value == 2) {
          Get.offNamed(VendorHomeScreen.routeName);
        } else {
          Get.offNamed(HomeScreen.routeName);
        }
      } catch (error) {
        print(error);
        SharedWidgets.errorDialog(
          context: context,
          body: ERROR_MESSAGE,
          title: 'Error 404',
          onConfirm: () {
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pop();
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                const Text(
                  'Log In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: emailController,
                  hint: 'Email',
                  onValidate: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Enter your email';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: passwordController,
                  hint: 'Password',
                  isObscure: isObscure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  onValidate: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Enter your Password';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildElevatedButton(
                  width: context.width,
                  onPress: _isLoading ? null : login,
                  btnText: 'User Log in',
                  btnColor: primaryColor,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildOutlinedButton(
                  onPress: () {
                    Get.offNamed(RegisterScreen.routeName);
                  },
                  btnText: 'Don\'t have an account? Sign up now',
                  btnColor: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
