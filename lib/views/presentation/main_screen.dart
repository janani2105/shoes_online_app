import 'package:flutter/material.dart';
import 'package:online_shop_app/controllers/mainscreen_provider.dart';
import 'package:online_shop_app/views/presentation/cart_page.dart';
import 'package:online_shop_app/views/presentation/favourites.dart';
import 'package:online_shop_app/views/presentation/home_page.dart';
import 'package:online_shop_app/views/presentation/profile_page.dart';
import 'package:online_shop_app/views/presentation/search_page.dart';
import 'package:online_shop_app/views/shared/bottom_nav.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const Favourites(),
    CartPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
