import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/vendors_controller.dart';

import '../../../buisness_logic_layer/profile_controller.dart';
import '../../../shared/shared_widgets.dart';
import '../../../utils/constants.dart';

class VendorProfilePage extends StatefulWidget {
  const VendorProfilePage({Key? key}) : super(key: key);

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage> {
  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final openTimeController = TextEditingController();
  final closeTimeController = TextEditingController();

  int? selectedCityId;

  @override
  void initState() {
    super.initState();
    getProfile();
    getCities();
  }

  Future<void> getProfile() async {
    final profileController = Get.find<ProfileController>();
    final vendorController = Get.find<VendorsController>();
    countryController.text = profileController.country.value;
    await vendorController.getVendorProfile();
    nameController.text = vendorController.vendor.value.name ?? '';
    addressController.text = vendorController.vendor.value.address ?? '';
    openTimeController.text = vendorController.vendor.value.openTime ?? '';
    closeTimeController.text = vendorController.vendor.value.closeTime ?? '';
  }

  Future<void> getCities() async {
    final profileController = Get.find<ProfileController>();
    await profileController.getCities();
  }

  Future<void> updateProfile() async {
    final vendorController = Get.find<VendorsController>();
    await vendorController.updateProfile(
      newCityId: selectedCityId,
      newName: nameController.text,
      newAddress: addressController.text,
      openTime: openTimeController.text,
      closeTime: closeTimeController.text,
    );
  }

  Future<void> deleteProfile() async {
    final profileController = Get.find<ProfileController>();
    await profileController.deleteProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final vendorController = Get.find<VendorsController>();
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
              SharedWidgets.buildClickableTextForm(
                controller: nameController,
                hint: 'Name',
              ),
              SizedBox(
                height: 16,
              ),
              SharedWidgets.buildClickableTextForm(
                controller: addressController,
                hint: 'Address',
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: SharedWidgets.buildClickableTextForm(
                      controller: openTimeController,
                      hint: 'Open Time',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SharedWidgets.buildClickableTextForm(
                      controller: closeTimeController,
                      hint: 'Close Time',
                    ),
                  ),
                ],
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
