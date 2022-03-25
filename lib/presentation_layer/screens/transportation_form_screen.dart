import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/enums/transportation_type.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

import '../../shared/shared_widgets.dart';
import 'payment_screen.dart';


class TransportationFormScreen extends StatefulWidget {
  static const String routeName = '/transportationFormScreen';
  const TransportationFormScreen({Key? key}) : super(key: key);

  @override
  State<TransportationFormScreen> createState() =>
      _TransportationFormScreenState();
}

class _TransportationFormScreenState extends State<TransportationFormScreen> {
  final fromCountryController = TextEditingController();
  final toCountryController = TextEditingController();

  TransportationType transType = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/imgs/app_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: SharedWidgets.appBar(title: ''),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                if (transType != TransportationType.custom)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      transType == TransportationType.sea
                          ? 'Sea Freight'
                          : 'Land Shipping',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SharedWidgets.buildClickableTextForm(
                  hint: 'Product',
                  onClick: null,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildClickableTextForm(
                  hint: 'Tons Weight',
                  onClick: null,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidgets.buildClickableTextForm(
                        controller: fromCountryController,
                        hint: 'From',
                        isIgnoringTextInput: true,
                        onClick: () {
                          // showCountryPicker(
                          //   context: context,
                          //   showPhoneCode: true,
                          //   onSelect: (Country country) {
                          //     fromCountryController.text = country.name;
                          //   },
                          // );
                        },
                        textColor: Colors.white,
                        onValidate: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Enter Country';
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
                        controller: toCountryController,
                        hint: 'To',
                        isIgnoringTextInput: true,
                        onClick: () {
                          // showCountryPicker(
                          //   context: context,
                          //   showPhoneCode: true,
                          //   onSelect: (Country country) {
                          //     toCountryController.text = country.name;
                          //   },
                          // );
                        },
                        textColor: Colors.white,
                        onValidate: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Enter Country';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                SharedWidgets.buildElevatedButton(
                  onPress: () {
                    Get.toNamed(PaymentScreen.routeName);
                  },
                  btnText: 'Done',
                  btnColor: primaryColor,
                  width: Get.width / 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
