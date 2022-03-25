import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/cart_controller.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

import '../../models/products.dart';
import '../../shared/shared_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/productDetails';
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Product product = Get.arguments as Product;

  double rating = 0;

  Future<void> addToCart(Product prod) async {
    // Add to Cart
    final cartController = Get.find<CartController>();
    await cartController.addCartItem(prod.id, prod.quantity);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidgets.appBar(
        title: product.name,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              SizedBox(
                width: Get.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  // child: Image.network(
                  //   product.imgUrl,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(
                  //   child: RatingBar.builder(
                  //     initialRating: 3,
                  //     minRating: 1,
                  //     direction: Axis.horizontal,
                  //     allowHalfRating: true,
                  //     itemCount: 5,
                  //     itemSize: 25,
                  //     itemBuilder: (context, _) => const Icon(
                  //       Icons.star,
                  //       color: Colors.black,
                  //     ),
                  //     onRatingUpdate: (value) {
                  //       rating = value;
                  //     },
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                child: Text(
                  '',
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              SizedBox(
                height: 16,
              ),
              SharedWidgets.buildElevatedButton(
                onPress: () async {
                  await addToCart(product);
                },
                btnText: 'Add to Cart',
                btnColor: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
