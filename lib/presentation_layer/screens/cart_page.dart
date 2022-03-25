import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/cart_controller.dart';
import 'package:tamween_flutter_project/models/cart.dart';
import 'package:tamween_flutter_project/shared/shared_widgets.dart';

import '../../models/products.dart';
import '../../utils/constants.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    getCartItems();
  }

  Future<void> getCartItems() async {
    final cartController = Get.find<CartController>();
    await cartController.getCartItems();
  }

  int getTotalQuantity() {
    final cartController = Get.find<CartController>();
    int total = 0;
    for (var cart in cartController.carts) {
      total += cart.quantity;
    }
    return total;
  }

  Future<void> changeCartQuantity(int id, int quantity) async {
    final cartController = Get.find<CartController>();
    cartController.changeCartItemQuantity(id, quantity);
  }

  Future<void> deleteCartItem(int id) async {
    final cartController = Get.find<CartController>();
    await cartController.deleteCartItem(id);
    SharedWidgets.successDialog(
      context: context,
      title: 'Deleted',
      body: 'Deleted Sucessfully',
      onConfirm: () {
        Get.back();
      },
    );
  }

  Widget buildVendorCardItem({
    required Cart product,
  }) {
    return Slidable(
      closeOnScroll: true,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(
                product.product.imgUrl,
                width: 70,
                height: 70,
                errorBuilder:
                    (BuildContext context, Object obj, StackTrace? s) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.close,
                      size: 35,
                      color: redColor,
                    ),
                  );
                },
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.vendor,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    // Text(
                    //   '\$ ${product.price * product.quantity}',
                    //   style: TextStyle(
                    //     color: primaryColor,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                width: Get.width * 0.25,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xff1D1C1C),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                        onTap: () {
                          if (product.quantity > 1) {
                            setState(() {
                              product.quantity--;
                            });
                            changeCartQuantity(product.id, product.quantity);
                          }
                        },
                      ),
                      Center(
                          child: Text(
                        '${product.quantity}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            product.quantity++;
                          });
                          changeCartQuantity(product.id, product.quantity);
                        },
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            autoClose: true,
            onPressed: (context) async {
              await deleteCartItem(product.id);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Obx(() {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartController.carts.length,
              itemBuilder: (context, i) {
                final product = cartController.carts[i];
                return buildVendorCardItem(
                  product: product,
                );
              },
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount:'),
                      Text(
                        '\$ ${getTotalQuantity().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
