import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/login_screen.dart';

import '../../buisness_logic_layer/auth_controller.dart';
import '../../buisness_logic_layer/profile_controller.dart';
import '../../shared/shared_widgets.dart';
import '../../utils/constants.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/registerScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  bool isObscure = true;

  int? selectedCityId;

  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final creditController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();

  void register() async {
    final isValid = formKey.currentState?.validate();
    if (isValid ?? false) {
      FocusScope.of(context).unfocus();

      try {
        setState(() {
          _isLoading = true;
        });
        await authController.registerUser(
          username: usernameController.text,
          email: emailController.text,
          credit: creditController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          password: passwordController.text,
          countryId: 1,
          cityId: 1,
        );
        setState(() {
          _isLoading = false;
        });

        Get.offNamed(HomeScreen.routeName);
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
            Get.back();
          },
        );
      }
    }
  }

  Future<void> getCities() async {
    final profileController = Get.find<ProfileController>();
    await profileController.getCities();
  }

  @override
  void initState() {
    super.initState();
    getCities();
    countryController.text = 'Egypt';
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
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
                  'Sign up',
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
                  controller: usernameController,
                  hint: 'Username',
                  onValidate: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Enter your username';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidgets.buildClickableTextForm(
                        controller: firstNameController,
                        hint: 'First Name',
                        onValidate: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Enter your Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SharedWidgets.buildClickableTextForm(
                        controller: lastNameController,
                        hint: 'Last Name',
                        onValidate: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Enter your Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: creditController,
                  hint: 'Credit',
                  inputType: TextInputType.number,
                  onValidate: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Enter your Credits';
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
                SharedWidgets.buildClickableTextForm(
                  controller: confirmPasswordController,
                  hint: 'Confirm Password',
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
                      return 'Enter your Confirm Password';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidgets.buildClickableTextForm(
                        controller: countryController,
                        hint: 'Country',
                        isIgnoringTextInput: true,
                        onClick: null,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Obx(() => Expanded(
                          child: SharedWidgets.buildBorderedDropDown<int?>(
                            value: selectedCityId,
                            items: profileController.cities
                                .map((element) => DropdownMenuItem<int?>(
                                      value: element.id,
                                      child: Text(element.name),
                                    ))
                                .toList(),
                            hint: 'City',
                            onChanged: (value) {
                              setState(() {
                                selectedCityId = value;
                              });
                            },
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                SharedWidgets.buildElevatedButton(
                  width: Get.width,
                  onPress: _isLoading ? null : register,
                  btnText: 'Sign up',
                  btnColor: primaryColor,
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildOutlinedButton(
                  onPress: () {
                    Get.offNamed(LoginScreen.routeName);
                  },
                  btnText: 'Already have an account? Login',
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
