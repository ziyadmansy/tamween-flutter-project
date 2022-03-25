import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:tamween_flutter_project/models/products.dart';
import 'package:tamween_flutter_project/models/vendor.dart';
import 'package:tamween_flutter_project/shared/shared_widgets.dart';

import '../shared/api_routes.dart';
import '../utils/constants.dart';

class VendorsController extends GetConnect {
  RxList<Vendor> vendors = <Vendor>[].obs;
  RxList<Product> products = <Product>[].obs;
  var vendor = Vendor(imgUrl: '').obs;

  Future<void> getVendors(int cityId) async {
    print(ApiRoutes.vendors);
    Response response = await post(
      ApiRoutes.vendors,
      {
        'token': SharedWidgets.token.value,
        'city': cityId,
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final List<dynamic>? decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);
    if (response.statusCode == 200) {
      vendors.clear();
      vendors.value = decodedResponseBody!
          .map<Vendor>((it) => Vendor.fromJson(it))
          .toList();
      vendors.refresh();
    } else {
      throw Exception();
    }
  }

  Future<void> getVendorProfile() async {
    print(ApiRoutes.vendorDetails(SharedWidgets.token.value));
    print(SharedWidgets.token.value);
    Response response = await get(
      ApiRoutes.vendorDetails(SharedWidgets.token.value),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final Map<String, dynamic> decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      vendor.value = Vendor.fromJson(decodedResponseBody);
      vendor.refresh();
      Get.snackbar('Success!', 'Loaded Successfully');
    } else {
      // throw Exception();
    }
  }

  Future<void> updateProfile({
    required String newName,
    required String newAddress,
    required String closeTime,
    required String openTime,
    required int? newCityId,
  }) async {
    print(ApiRoutes.vendorDetails(SharedWidgets.token.value));
    Response response = await put(
      ApiRoutes.vendorDetails(SharedWidgets.token.value),
      {
        'country': '1',
        'city': '$newCityId',
        'name': newName,
        'address': newAddress,
        'open_time': openTime,
        'close_time': closeTime,
        'LAT': '123456',
        'LONG': '4484223',
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);
    if (response.statusCode == 200) {
      vendor.value = Vendor.fromJson(decodedResponseBody);
      vendor.refresh();
      Get.snackbar('Success!', 'Updated Successfully');
    } else {
      throw Exception();
    }
  }

  Future<void> getVendorProducts({int? vendorId}) async {
    print(ApiRoutes.vendorProducts(vendorId ?? SharedWidgets.vendorId.value));
    products.clear();
    Response response = await get(
      ApiRoutes.vendorProducts(vendorId ?? SharedWidgets.vendorId.value),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);
    if (response.statusCode == 200) {
      products.value = (decodedResponseBody as List<dynamic>)
          .map((it) => Product.fromJson(it))
          .toList();
    } else {
      throw Exception();
    }
  }

  Future<void> editVendorProduct({
    required int prodId,
    required String prodName,
    required String prodPrice,
    required String prodQuantity,
  }) async {
    print(ApiRoutes.editProduct(prodId));
    Response response = await put(
      ApiRoutes.editProduct(prodId),
      {
        'token': SharedWidgets.token.value,
        'name': prodName,
        'price': double.parse(prodPrice),
        'quantity': int.parse(prodQuantity),
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);
    if (response.statusCode == 200) {
      products[products.indexWhere((prod) => prod.id == prodId)] =
          Product.fromJson(decodedResponseBody);
      products.refresh();
    } else {
      throw Exception();
    }
  }

  Future<void> addVendorProduct({
    required String prodName,
    required String prodPrice,
    required String prodQuantity,
    required File image,
  }) async {
    try {
      print(ApiRoutes.vendorProducts(SharedWidgets.vendorId.value));
      var formData = dio.FormData.fromMap({
        'token': SharedWidgets.token.value,
        'name': prodName,
        'price': double.parse(prodPrice),
        'quantity': int.parse(prodQuantity),
        'image': await dio.MultipartFile.fromFile(
          image.path,
          filename: '$prodName.jpg',
        )
      });
      var response = await dio.Dio().post(
        ApiRoutes.vendorProducts(SharedWidgets.vendorId.value),
        data: formData,
      );
      // final form = FormData({
      //   'token': SharedWidgets.token.value,
      //   'name': prodName,
      //   'price': double.parse(prodPrice),
      //   'quantity': int.parse(prodQuantity),
      //   'image': MultipartFile(
      //     image,
      //     filename: '$prodName.jpg',
      //   ),
      // });
      // var response = await post(
      //   ApiRoutes.vendorProducts(SharedWidgets.vendorId.value),
      //   form,
      //   headers: {
      //     'Content-Type': '*/*',
      //     'Accept': '*/*',
      //   },
      // );

      final decodedResponseBody = response.data;
      print(decodedResponseBody);
      print(response.statusCode);
      if (response.statusCode == 201) {
        products.add(Product.fromJson(decodedResponseBody));
        products.refresh();
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteVendor(int id) async {
    print(ApiRoutes.deleteVendor(id));
    print(SharedWidgets.token.value);
    Response response = await post(
      ApiRoutes.deleteVendor(id),
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
      vendors.removeWhere((vend) => vend.id == id);
      vendors.refresh();
    } else {
      Get.snackbar('Error!', ERROR_MESSAGE);
      throw Exception();
    }
  }

  // Future<void> getVendorDetails(int vendorId) async {
  //   print(ApiRoutes.vendorDetails(vendorId));
  //   Response response = await get(
  //     ApiRoutes.vendorDetails(vendorId),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': '*/*',
  //     },
  //   );

  //   final List decodedResponseBody = response.body;
  //   print(decodedResponseBody);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     vendors.value =
  //         decodedResponseBody.map((it) => Vendor.fromJson(it)).toList();
  //     // vendors.refresh();
  //   } else {
  //     throw Exception();
  //   }
  // }
}
