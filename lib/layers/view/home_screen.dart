import 'package:flutter/material.dart';
import 'package:fresh_shelf/core/app/state/app_state.dart';
import 'package:fresh_shelf/layers/view/screens/cart/cart_screen.dart';
import 'package:fresh_shelf/layers/view/screens/category_screen/category_screen.dart';
import 'package:fresh_shelf/layers/view/screens/settings/settings_screen.dart';
import 'package:fresh_shelf/layers/view/screens/wish_list/wish_list.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    CategoryScreen(),
    WishListScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  final Map<String, IconData> _icons = {
    "Home": Icons.home,
    "Wish List": Icons.list,
    "Cart": Icons.shopping_cart,
    "Settings": Icons.settings
  };

  final Map<String, String> _titles = {
    "Home": S.current.home,
    "Wish List": S.current.wishList,
    "Cart": S.current.cart,
    "Settings": S.current.settings
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state != AppLifecycleState.resumed) {
      print(state);
      Provider.of<AppState>(context, listen: false).createCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: _icons
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(
                    icon,
                    size: 30,
                  ),
                  label: _titles[title],
                )))
            .values
            .toList(),
        selectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
        currentIndex: _currentIndex,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
