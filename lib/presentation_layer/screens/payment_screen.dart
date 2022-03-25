import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import '../../shared/shared_widgets.dart';


class PaymentScreen extends StatefulWidget {
  static const String routeName = '/paymentScreen';
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final countryController = TextEditingController();

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
                CreditCardWidget(
                  cardType: CardType.visa,
                  cardNumber: cardNumberController.text,
                  expiryDate: expiryDateController.text,
                  cardHolderName: cardNameController.text,
                  obscureCardNumber: false,
                  cvvCode: cvvController.text,
                  showBackView:
                      false, //true when you want to show cvv(back) view
                  onCreditCardWidgetChange: (CreditCardBrand brand) {
                    print(brand.brandName);
                  },
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: cardNameController,
                  hint: 'Card Holder Name',
                  onClick: null,
                  textColor: Colors.white,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: cardNumberController,
                  hint: 'Card Number',
                  onClick: null,
                  inputType: TextInputType.number,
                  textColor: Colors.white,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidgets.buildClickableTextForm(
                        controller: expiryDateController,
                        hint: 'Expiry Date',
                        onClick: null,
                        textColor: Colors.white,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SharedWidgets.buildClickableTextForm(
                        controller: cvvController,
                        hint: 'CVV',
                        onClick: null,
                        textColor: Colors.white,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SharedWidgets.buildClickableTextForm(
                  controller: countryController,
                  hint: 'Country',
                  isIgnoringTextInput: true,
                  onClick: () {
                    FocusScope.of(context).unfocus();
                    // showCountryPicker(
                    //   context: context,
                    //   showPhoneCode: true,
                    //   onSelect: (Country country) {
                    //     countryController.text = country.name;
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
