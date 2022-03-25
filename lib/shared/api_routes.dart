class ApiRoutes {
  static const String baseUrl = 'http://18.193.185.100';

  static const String apiUrl = '$baseUrl/api';

  static const String login = '$apiUrl/login/';
  static const String register = '$apiUrl/register/';

  static const String profile = '$apiUrl/profile/';

  static const String vendors = '$apiUrl/vendors/';
  static String vendorDetails(String token) => '$apiUrl/vendor/$token';
  static String updateVendor(String token) => '$apiUrl/vendors/$token';
  static String deleteVendor(int vendorId) => '$apiUrl/vendors/$vendorId';

  static String vendorProducts(int id) => '$apiUrl/vendor/products/$id';
  // static String productDetails(int prodId) => '$apiUrl/vendor/product/$prodId';
  static String editProduct(int prodId) => '$apiUrl/vendor/product/$prodId';
  static String deleteProduct(int prodId) => '$apiUrl/vendor/product/$prodId';

  static const String cities = '$apiUrl/country/1/';

  static const String cartItems = '$apiUrl/cart/';
  static const String addProductToCart = '$apiUrl/cart-details/';
  static const String changeCartQuantity = '$apiUrl/cart-details/';
  static const String deleteCartItem = '$apiUrl/cart-product/';
}
