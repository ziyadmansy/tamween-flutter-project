import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/profile_controller.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/vendors_controller.dart';
import 'package:tamween_flutter_project/models/vendor.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor_products_screen.dart';
import 'package:tamween_flutter_project/shared/shared_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key}) : super(key: key);

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  @override
  void initState() {
    super.initState();
    getVendors();
  }

  Future<void> getVendors() async {
    final vendorsController = Get.find<VendorsController>();
    await vendorsController.getVendors(1);
    print(vendorsController.vendors.length);
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Widget buildVendorCardItem({
    required VoidCallback? onPressed,
    required Vendor vendor,
  }) {
    return Card(
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
                vendor.imgUrl,
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
                      vendor.name ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${vendor.country}, ${vendor.city}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      vendor.address ?? '',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  await openMap(
                    double.tryParse(vendor.lAT.toString()) ?? 31.31,
                    double.tryParse(vendor.lONG.toString()) ?? 31.31,
                  );
                },
                icon: Icon(
                  Icons.map,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var vendorsController = Get.find<VendorsController>();
    return Obx(() => ListView.builder(
          itemCount: vendorsController.vendors.length,
          itemBuilder: (context, i) {
            final vendor = vendorsController.vendors[i];
            return buildVendorCardItem(
              vendor: vendor,
              onPressed: () {
                Get.toNamed(
                  VendorProductsScreen.routeName,
                  arguments: vendor,
                );
              },
            );
          },
        ));
  }
}
