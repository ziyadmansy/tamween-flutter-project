import 'package:get/get.dart';
import 'package:tamween_flutter_project/models/cart.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

import '../shared/api_routes.dart';
import '../shared/shared_widgets.dart';

class CartController extends GetConnect {
  RxList<Cart> carts = <Cart>[].obs;

  Future<void> getCartItems() async {
    print(ApiRoutes.cartItems);
    print(SharedWidgets.token.value);
    Response response = await post(
      ApiRoutes.cartItems,
      {
        'token': SharedWidgets.token.value,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final List<dynamic> decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      carts.value =
          decodedResponseBody.map<Cart>((cart) => Cart.fromJson(cart)).toList();
      Get.snackbar('Success!', 'Loaded Successfully');
    } else {
      // throw Exception();
      Get.snackbar('Error!', ERROR_MESSAGE);
    }
  }

  Future<void> addCartItem(int prodId, int quantity) async {
    print(ApiRoutes.addProductToCart);
    print(SharedWidgets.token.value);
    Response response = await post(
      ApiRoutes.addProductToCart,
      {
        'token': SharedWidgets.token.value,
        'product': prodId,
        'quantity': quantity,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final Map<String, dynamic> decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      carts.add(Cart.fromJson(decodedResponseBody));
      carts.refresh();
    } else {
      // throw Exception();
      Get.snackbar('Error!', ERROR_MESSAGE);
    }
  }

  Future<void> changeCartItemQuantity(int id, int quantity) async {
    print(ApiRoutes.changeCartQuantity);
    print(SharedWidgets.token.value);
    Response response = await put(
      ApiRoutes.changeCartQuantity,
      {
        'token': SharedWidgets.token.value,
        'id': id,
        'quantity': quantity,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final Map<String, dynamic> decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      carts[carts.indexWhere((cart) => cart.id == id)] =
          Cart.fromJson(decodedResponseBody);
      carts.refresh();
    } else {
      // throw Exception();
      Get.snackbar('Error!', ERROR_MESSAGE);
    }
  }

  Future<void> deleteCartItem(int id) async {
    print(ApiRoutes.deleteCartItem);
    print(SharedWidgets.token.value);
    Response response = await post(
      ApiRoutes.deleteCartItem,
      {
        'token': SharedWidgets.token.value,
        'id': id,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      carts.removeWhere((cart) => cart.id == id);
      carts.refresh();
    } else {
      // throw Exception();
      Get.snackbar('Error!', ERROR_MESSAGE);
    }
  }
}
