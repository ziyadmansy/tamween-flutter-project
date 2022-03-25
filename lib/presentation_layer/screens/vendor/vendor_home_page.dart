import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/vendors_controller.dart';
import 'package:tamween_flutter_project/models/products.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/edit_product.dart';

import '../../../shared/shared_widgets.dart';
import '../../../utils/constants.dart';

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({Key? key}) : super(key: key);

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  Widget buildVendorProductItem({
    required VoidCallback? onPressed,
    required Product product,
  }) {
    return Slidable(
      closeOnScroll: true,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(kBorderRadius),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.network(
                  product.imgUrl,
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
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          // SlidableAction(
          //   label: 'Delete',
          //   backgroundColor: Colors.red,
          //   foregroundColor: Colors.white,
          //   icon: Icons.delete,
          //   autoClose: true,
          //   onPressed: (context) async {
          //     await deleteVendorItem(product.id);
          //   },
          // ),
        ],
      ),
    );
  }

  Future<void> deleteVendorItem(int id) async {
    final vendorController = Get.find<VendorsController>();
    await vendorController.deleteVendor(id);
    SharedWidgets.successDialog(
      context: context,
      title: 'Deleted',
      body: 'Deleted Sucessfully',
      onConfirm: () {
        Get.back();
      },
    );
  }

  Future<void> getVendorItems() async {
    final vendorController = Get.find<VendorsController>();
    await vendorController.getVendorProducts();
  }

  @override
  void initState() {
    super.initState();
    getVendorItems();
  }

  @override
  Widget build(BuildContext context) {
    final vendorController = Get.find<VendorsController>();
    return Obx(() => ListView.builder(
          itemCount: vendorController.products.length,
          itemBuilder: (context, i) {
            final product = vendorController.products[i];
            return buildVendorProductItem(
              product: product,
              onPressed: () {
                Get.toNamed(
                  EditProduct.routeName,
                  arguments: product,
                );
              },
            );
          },
        ));
  }
}
