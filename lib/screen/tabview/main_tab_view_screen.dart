import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/screen/cart/cart_tab_screen.dart';
import 'package:fruitmarket/screen/favorites/favorites_tab_screen.dart';
import 'package:fruitmarket/screen/home/home_tab_screen.dart';
import 'package:fruitmarket/screen/my_account/my_account_tab_screen.dart';

class MainTabViewScreen extends StatefulWidget {
  const MainTabViewScreen({super.key});

  @override
  State<MainTabViewScreen> createState() => _MainTabViewScreenState();
}

class _MainTabViewScreenState extends State<MainTabViewScreen>
    with SingleTickerProviderStateMixin {
  int selectTab = 0;
  TabController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: controller, children: [
        HomeTabScreen(),
        CartTabScreen(),
        FavoritesTabScreen(),
        MyAccountTabScreen()
      ]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, -2))
        ]),
        child: SafeArea(
          child: TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              labelColor: TColor.active,
              unselectedLabelColor: TColor.inactive,
              tabs: [
                Tab(
                  icon: Image.asset(
                    "assets/img/home_tab.png",
                    color: selectTab == 0 ? TColor.active : TColor.inactive,
                    width: 30,
                    height: 30,
                  ),
                  text: "Home",
                ),
                Tab(
                  icon: Image.asset(
                    "assets/img/cart_tab.png",
                    color: selectTab == 1 ? TColor.active : TColor.inactive,
                    width: 30,
                    height: 30,
                  ),
                  text: "Shopping cart",
                ),
                Tab(
                  icon: Image.asset(
                    "assets/img/fav_tab.png",
                    color: selectTab == 2 ? TColor.active : TColor.inactive,
                    width: 30,
                    height: 30,
                  ),
                  text: "Favourite",
                ),
                Tab(
                  icon: Image.asset(
                    "assets/img/user_tab.png",
                    color: selectTab == 3 ? TColor.active : TColor.inactive,
                    width: 30,
                    height: 30,
                  ),
                  text: "My Account",
                )
              ]),
        ),
      ),
    );
  }
}
