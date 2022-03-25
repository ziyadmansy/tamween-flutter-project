import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/product_details.dart';

import '../../buisness_logic_layer/cart_controller.dart';
import '../../models/products.dart';
import '../../utils/constants.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Future<void> addToCart(Product prod) async {
    // Add to Cart
    final cartController = Get.find<CartController>();
    await cartController.addCartItem(prod.id, 1);
    Get.snackbar('Success', 'Item added to Cart');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: () async {
          // Get.toNamed(ProductDetailsScreen.routeName, arguments: product);
          await addToCart(widget.product);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 140,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    widget.product.imgUrl,
                    fit: BoxFit.fill,
                    errorBuilder:
                        (BuildContext context, Object obj, StackTrace? s) {
                      return Icon(
                        Icons.close,
                        size: 28,
                        color: redColor,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$${widget.product.price}',
              ),
              // IconButton(
              //   onPressed: () async {
              //     await addToCart(widget.product);
              //   },
              //   icon: Icon(
              //     Icons.shopping_cart,
              //     color: primaryColor,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
