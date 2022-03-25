import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tamween_flutter_project/shared/initial_app_binding.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

import 'shared/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
      initialBinding: InitialBindings(),
    );
  }
}
