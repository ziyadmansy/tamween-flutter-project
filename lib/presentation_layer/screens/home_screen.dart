import 'package:flutter/material.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/cart_page.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/menu_screen.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/profile_page.dart';
import 'package:tamween_flutter_project/presentation_layer/screens/vendors_page.dart';
import 'package:tamween_flutter_project/shared/shared_widgets.dart';
import 'package:tamween_flutter_project/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomNav = 0;
  List<Map<String, Object>> _bottomNavItems = [];

  @override
  void initState() {
    super.initState();
    _bottomNavItems = [
      {
        'title': 'Vendors',
        'body': VendorsPage(),
      },
      {
        'title': 'Profile',
        'body': ProfilePage(),
      },
      {
        'title': 'Cart',
        'body': CartPage(),
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
            icon: Icons.supervisor_account,
          ),
          buildBottomNavItem(
            title: _bottomNavItems[1]['title'] as String,
            icon: Icons.account_circle,
          ),
          buildBottomNavItem(
            title: _bottomNavItems[2]['title'] as String,
            icon: Icons.shopping_cart,
          ),
          buildBottomNavItem(
            title: _bottomNavItems[3]['title'] as String,
            icon: Icons.menu,
          ),
        ],
      ),
      body: _bottomNavItems[_selectedBottomNav]['body'] as Widget,
    );
  }
}
