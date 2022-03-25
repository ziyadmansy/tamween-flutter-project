import 'package:tamween_flutter_project/shared/api_routes.dart';

class Product {
  final int id;
  final String name;
  final String imgUrl;
  final double price;
  final int quantity;
  final int vendor;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.vendor,
    required this.imgUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'],
      vendor: json['vendor'],
      imgUrl: '${ApiRoutes.baseUrl}${json['image']}',
    );
  }
}
