import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../buisness_logic_layer/vendors_controller.dart';
import '../../models/products.dart';
import '../../models/vendor.dart';
import '../../shared/shared_widgets.dart';
import '../widgets/category_title.dart';
import '../widgets/product_item.dart';

class VendorProductsScreen extends StatefulWidget {
  static const routeName = '/vendorProducts';
  const VendorProductsScreen({Key? key}) : super(key: key);

  @override
  State<VendorProductsScreen> createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen> {
  final Vendor vendor = Get.arguments;

  @override
  void initState() {
    super.initState();
    getVendorItems();
  }

  Future<void> getVendorItems() async {
    final vendorController = Get.find<VendorsController>();
    await vendorController.getVendorProducts(vendorId: vendor.id);
  }

  // Widget buildFilteredList() {
  //   return GridView.builder(
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2, childAspectRatio: 0.8),
  //       itemCount: newProducts.length,
  //       shrinkWrap: true,
  //       physics: const ClampingScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         return ProductItem(
  //           product: newProducts[index],
  //         );
  //       });
  // }

  // List<Product> getProductsByCategory(String category) {
  //   List<Product> filteredProducts = [];
  //   for (var product in allProducts) {
  //     if (product.category == category) {
  //       filteredProducts.add(product);
  //     }
  //   }
  //   return filteredProducts;
  // }

  @override
  Widget build(BuildContext context) {
    final vendorsController = Get.find<VendorsController>();

    return Obx(
      () => Scaffold(
        appBar: SharedWidgets.appBar(
          title: 'Products',
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: vendorsController.products.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, i) {
            final prod = vendorsController.products[i];
            return ProductItem(
              product: prod,
            );
          },
        ),
      ),
    );
  }
}
