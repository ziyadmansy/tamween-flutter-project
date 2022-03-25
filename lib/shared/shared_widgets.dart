import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../buisness_logic_layer/auth_controller.dart';
import '../utils/constants.dart';

class SharedWidgets {
  static var token = Get.find<AuthController>().token;
  static var vendorId = Get.find<AuthController>().vendorId;
  
  static AppBar appBar({required String title, List<Widget>? actions}) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(title),
      elevation: 0.0,
      actions: actions,
    );
  }

  static Widget buildBorderedDropDown<T>({
    required T value,
    required List<DropdownMenuItem<T>> items,
    required String hint,
    required void Function(T?)? onChanged,
    String? Function(T?)? onValidate,
    double? itemHeight,
    bool isDense = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        value: value,
        hint: Text(hint),
        isExpanded: true,
        isDense: isDense,
        itemHeight: itemHeight,
        decoration: InputDecoration(
          hintText: hint,
          label: Text(hint),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        items: items,
        onChanged: onChanged,
        validator: onValidate,
      ),
    );
  }

  static Widget buildElevatedButton({
    required void Function()? onPress,
    required String btnText,
    Color? btnColor,
    double? width,
    TextStyle? btnTextStyle,
  }) {
    return SizedBox(
      height: 40,
      width: width,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(btnText),
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          onSurface: btnColor,
          textStyle: btnTextStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
      ),
    );
  }

  static Widget buildOutlinedButton({
    required void Function()? onPress,
    required String btnText,
    Color? btnColor,
    double? width,
    TextStyle? btnTextStyle,
  }) {
    return SizedBox(
      height: 40,
      width: width,
      child: OutlinedButton(
        onPressed: onPress,
        child: Text(btnText),
        style: OutlinedButton.styleFrom(
          primary: btnColor,
          onSurface: btnColor,
          textStyle: btnTextStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
      ),
    );
  }

  static void errorDialog({
    required BuildContext context,
    VoidCallback? onConfirm,
    String? title,
    String? body,
  }) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: title,
      text: body,
      confirmBtnText: 'Ok',
      onConfirmBtnTap: onConfirm,
    );
  }

  static void successDialog({
    required BuildContext context,
    String? title,
    String? body,
    VoidCallback? onConfirm,
    String confirmBtnText = 'OK',
  }) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: title,
      text: body,
      confirmBtnText: confirmBtnText,
      onConfirmBtnTap: onConfirm,
    );
  }

  static void loadingDialog({
    required BuildContext context,
    String? title,
    String? body,
    VoidCallback? onConfirm,
    required bool dismissable,
  }) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      title: title,
      text: body,
      onConfirmBtnTap: onConfirm,
      barrierDismissible: dismissable,
    );
  }

  static void warningDialog({
    required BuildContext context,
    String? title,
    String? body,
    VoidCallback? onConfirm,
  }) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      title: title,
      text: body,
      confirmBtnText: 'Ok',
      onConfirmBtnTap: onConfirm,
    );
  }

  static Widget buildClickableTextForm({
    VoidCallback? onClick,
    String? hint,
    String? Function(String? val)? onValidate,
    void Function(String)? onChanged,
    TextEditingController? controller,
    bool isIgnoringTextInput = false,
    bool isEnabled = true,
    String initialText = '',
    TextInputType? inputType,
    Widget? prefix,
    Widget? suffix,
    Color? textColor,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: IgnorePointer(
        ignoring: isIgnoringTextInput,
        child: TextFormField(
          controller: controller,
          validator: onValidate,
          enabled: isEnabled,
          onChanged: onChanged,
          obscureText: isObscure,
          decoration: InputDecoration(
            enabledBorder: kEnabledBorder,
            focusedBorder: kFocusedBorder,
            disabledBorder: kEnabledBorder,
            hintText: hint,
            labelText: hint,
            prefix: prefix,
            suffix: suffix,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
              color: textColor,
            ),
            labelStyle: TextStyle(
              color: textColor,
            ),
          ),
          style: TextStyle(
            color: textColor,
          ),
          keyboardType: inputType,
        ),
      ),
    );
  }
}
