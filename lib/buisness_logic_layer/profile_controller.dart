import 'package:get/get.dart';
import 'package:tamween_flutter_project/buisness_logic_layer/auth_controller.dart';
import 'package:tamween_flutter_project/models/city.dart';
import 'package:tamween_flutter_project/models/profile.dart';
import 'package:tamween_flutter_project/shared/shared_widgets.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

import '../shared/api_routes.dart';

class ProfileController extends GetConnect {
  var id = 0.obs;
  var country = 'Egypt'.obs;
  var city = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var credit = (0.0).obs;

  RxList<City> cities = <City>[].obs;

  Future<void> getCities() async {
    print(ApiRoutes.cities);
    print(SharedWidgets.token.value);
    Response response = await get(
      ApiRoutes.cities,
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    final decodedResponseBody = response.body;
    print(decodedResponseBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      cities.value = (decodedResponseBody as List<dynamic>)
          .map<City>((e) => City(id: e['id'], name: e['city']))
          .toList();
      print(id);
    } else {
      Get.snackbar('Error!', ERROR_MESSAGE);
      // throw Exception();
    }
  }

  Future<void> getProfile() async {
    print(ApiRoutes.profile);
    print(SharedWidgets.token.value);
    Response response = await post(
      ApiRoutes.profile,
      {
        'token': SharedWidgets.token.value,
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
      id.value = decodedResponseBody['id'];
      country.value = decodedResponseBody['country'];
      city.value = decodedResponseBody['city'];
      firstName.value = decodedResponseBody['first_name'];
      lastName.value = decodedResponseBody['last_name'];
      credit.value = double.parse(decodedResponseBody['credit'].toString());
      Get.snackbar('Success!', 'Loaded Successfully');
      print(id);
    } else {
      // throw Exception();
    }
  }

  Future<void> updateProfile({
    required String newfirstName,
    required String newLastName,
    required int? newCityId,
    required double newCredit,
  }) async {
    print(ApiRoutes.profile);
    Response response = await put(
      ApiRoutes.profile,
      {
        'token': SharedWidgets.token.value,
        'country': 1,
        'city': newCityId,
        'first_name': newfirstName,
        'last_name': newLastName,
        'credit': newCredit,
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
      id.value = decodedResponseBody['id'];
      country.value = decodedResponseBody['country'];
      city.value = decodedResponseBody['city'];
      firstName.value = decodedResponseBody['first_name'];
      lastName.value = decodedResponseBody['last_name'];
      credit.value = double.parse(decodedResponseBody['credit'].toString());
      Get.snackbar('Success!', 'Update Successfully');
      print(id);
    } else {
      throw Exception();
    }
  }

  Future<void> deleteProfile() async {
    print(ApiRoutes.profile);
    Response response = await post(
      ApiRoutes.profile,
      {
        'token': SharedWidgets.token.value,
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
      print('deleted');
      Get.snackbar('Success!', 'Deleted Successfully');
    } else {
      throw Exception();
    }
  }
}
