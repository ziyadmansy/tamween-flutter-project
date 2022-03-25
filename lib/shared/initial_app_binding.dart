import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/auth_controller.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/cart_controller.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/profile_controller.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/vendors_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(ProfileController());
    Get.put(VendorsController());
    Get.put(CartController());
  }
}
