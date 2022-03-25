import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/vendors_controller.dart';
import 'package:tamween_flutter_project/models/products.dart';

import '../../../shared/shared_widgets.dart';
import '../../../utils/constants.dart';

class EditProduct extends StatefulWidget {
  static const String routeName = '/editVendorProduct';
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final Product product = Get.arguments;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = product.name;
    priceController.text = product.price.toString();
    quantityController.text = product.quantity.toString();
  }

  void submit() async {
    final isValid = formKey.currentState?.validate();
    if (isValid ?? false) {
      FocusScope.of(context).unfocus();
      final vendorController = Get.find<VendorsController>();

      try {
        await vendorController.editVendorProduct(
          prodId: product.id,
          prodName: nameController.text,
          prodPrice: priceController.text,
          prodQuantity: quantityController.text,
        );

        Get.back();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidgets.appBar(title: 'Edit Product'),
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
