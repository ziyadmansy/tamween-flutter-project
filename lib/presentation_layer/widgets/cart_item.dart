import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/products.dart';

class CartItem extends StatelessWidget {
  Product allProduct;

  CartItem({Key? key, required this.allProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: Get.width,
      height: Get.height * 0.15,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: Get.width * 0.4,
            height: Get.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // child: Image.asset(allProduct.imgUrl, fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            width: Get.width * 0.03,
          ),
          SizedBox(
            width: Get.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allProduct.name,
                  style: const TextStyle(
                      color: Color(0xff1D1C1C),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${allProduct.price}',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    ),
                    Text(
                      'x${allProduct.quantity.toString()}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
