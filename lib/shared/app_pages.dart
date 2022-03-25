import 'package:get/get.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/cart_page.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/payment_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/signup_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/splash_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/transportation_form_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/add_product.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/edit_product.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/vendor_home_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor_products_screen.dart';

import '../presentation_layer/screens/home_screen.dart';
import '../presentation_layer/screens/login_screen.dart';
import '../presentation_layer/screens/product_details.dart';

class AppPages {
  AppPages._();

  static const String initialRoute = SplashScreen.routeName;

  static final List<GetPage> routes = [
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RegisterScreen.routeName,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: TransportationFormScreen.routeName,
      page: () => const TransportationFormScreen(),
    ),
    GetPage(
      name: PaymentScreen.routeName,
      page: () => const PaymentScreen(),
    ),
    GetPage(
      name: VendorProductsScreen.routeName,
      page: () => const VendorProductsScreen(),
    ),
    GetPage(
      name: ProductDetailsScreen.routeName,
      page: () => const ProductDetailsScreen(),
    ),
    GetPage(
      name: CartPage.routeName,
      page: () => const CartPage(),
    ),
    GetPage(
      name: VendorHomeScreen.routeName,
      page: () => const VendorHomeScreen(),
    ),
    GetPage(
      name: EditProduct.routeName,
      page: () => const EditProduct(),
    ),
    GetPage(
      name: AddProductScreen.routeName,
      page: () => const AddProductScreen(),
    ),
  ];
}
