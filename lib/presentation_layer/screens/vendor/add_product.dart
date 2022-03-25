import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/vendors_controller.dart';
import 'package:tamween_flutter_project/models/products.dart';

import '../../../shared/shared_widgets.dart';
import '../../../utils/constants.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/addVendorProduct';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();

  XFile? image;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void submit() async {
    final isValid = formKey.currentState?.validate();
    if ((isValid ?? false) && image != null) {
      FocusScope.of(context).unfocus();
      final vendorController = Get.find<VendorsController>();

      try {
        await vendorController.addVendorProduct(
          prodName: nameController.text,
          prodPrice: priceController.text,
          prodQuantity: quantityController.text,
          image: File(image!.path),
        );

        Get.back();
        Get.snackbar('Success!', 'Product Added');
      } catch (error) {
        print(error);
        SharedWidgets.errorDialog(
          context: context,
          body: ERROR_MESSAGE,
          title: 'Error 404',
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }

  Future<void> pickImageGallery() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidgets.appBar(title: 'Add Product'),
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
                SharedWidgets.buildClickableTextForm(
                  controller: nameController,
                  hint: 'Name',
                  onValidate: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Enter your Name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: priceController,
                  hint: 'Price',
                  inputType: TextInputType.number,
                  onValidate: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Enter your Price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: quantityController,
                  hint: 'Quantity',
                  inputType: TextInputType.number,
                  onValidate: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Enter your Price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                image == null
                    ? SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            'Pick an Image',
                          ),
                        ))
                    : Image.file(
                        File(image!.path),
                        width: 100,
                        height: 100,
                      ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildElevatedButton(
                  width: Get.width,
                  onPress: pickImageGallery,
                  btnText: 'Attack Image',
                  btnColor: greenColor,
                ),
                SizedBox(
                  height: 32,
                ),
                SharedWidgets.buildElevatedButton(
                  width: Get.width,
                  onPress: submit,
                  btnText: 'Submit',
                  btnColor: primaryColor,
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
