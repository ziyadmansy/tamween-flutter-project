import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/profile_controller.dart';
import 'package:tamween_flutter_project/shared/shared_widgets.dart';

import '../../utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final creditController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final countryController = TextEditingController();

  int? selectedCityId;

  @override
  void initState() {
    super.initState();
    getProfile();
    getCities();
  }

  Future<void> getProfile() async {
    final profileController = Get.find<ProfileController>();
    countryController.text = profileController.country.value;
    await profileController.getProfile();
    firstNameController.text = profileController.firstName.value;
    lastNameController.text = profileController.lastName.value;
    creditController.text = profileController.credit.value.toString();
  }

  Future<void> getCities() async {
    final profileController = Get.find<ProfileController>();
    await profileController.getCities();
  }

  Future<void> updateProfile() async {
    final profileController = Get.find<ProfileController>();
    await profileController.updateProfile(
      newfirstName: firstNameController.text,
      newLastName: lastNameController.text,
      newCredit: double.parse(creditController.text),
      newCityId: selectedCityId,
    );
  }

  Future<void> deleteProfile() async {
    final profileController = Get.find<ProfileController>();
    await profileController.deleteProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: SharedWidgets.buildClickableTextForm(
                      controller: firstNameController,
                      initialText: profileController.firstName.value,
                      hint: 'First Name',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SharedWidgets.buildClickableTextForm(
                      controller: lastNameController,
                      initialText: profileController.lastName.value,
                      hint: 'Last Name',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SharedWidgets.buildClickableTextForm(
                controller: creditController,
                initialText: profileController.credit.value.toString(),
                hint: 'Credit',
                inputType: TextInputType.number,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: SharedWidgets.buildClickableTextForm(
                      initialText: profileController.country.value,
                      controller: countryController,
                      hint: 'Country',
                      isIgnoringTextInput: true,
                      onClick: null,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
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
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              SharedWidgets.buildElevatedButton(
                onPress: updateProfile,
                btnText: 'Update Profie',
                btnColor: primaryColor,
              ),
              SizedBox(
                height: 32,
              ),
              SharedWidgets.buildElevatedButton(
                onPress: updateProfile,
                btnText: 'Delete Profie',
                btnColor: redColor,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      );
    });
  }
}
