import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/add_product.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/vendor_home_page.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendor/vendor_profile_page.dart';

import '../../../shared/shared_widgets.dart';
import '../../../utils/constants.dart';
import '../menu_screen.dart';

class VendorHomeScreen extends StatefulWidget {
  static const String routeName = '/vendorHomeScreen';
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  int _selectedBottomNav = 0;
  List<Map<String, Object>> _bottomNavItems = [];

  @override
  void initState() {
    super.initState();
    _bottomNavItems = [
      {
        'title': 'Home',
        'body': VendorHomePage(),
      },
      {
        'title': 'Profile',
        'body': VendorProfilePage(),
      },
      {
        'title': 'Menu',
        'body': MenuPage(),
      },
    ];
  }

  BottomNavigationBarItem buildBottomNavItem({
    required IconData icon,
    required String title,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidgets.appBar(
        title: _bottomNavItems[_selectedBottomNav]['title'] as String,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNav,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 16,
        onTap: (int i) {
          setState(() {
            _selectedBottomNav = i;
          });
        },
        items: [
          buildBottomNavItem(
            title: _bottomNavItems[0]['title'] as String,
            icon: Icons.home,
          ),
          buildBottomNavItem(
            title: _bottomNavItems[1]['title'] as String,
            icon: Icons.account_circle,
          ),
          buildBottomNavItem(
            title: _bottomNavItems[2]['title'] as String,
            icon: Icons.menu,
          ),
        ],
      ),
      body: _bottomNavItems[_selectedBottomNav]['body'] as Widget,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AddProductScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
