import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/screen/admin/dashboard/admin_dashboard_tab_screen.dart';
import 'package:fruitmarket/screen/admin/my_account/admin_my_account_tab_screen.dart';
import 'package:fruitmarket/screen/admin/order/new_order_list_screen.dart';
import 'package:fruitmarket/screen/favorites/favorites_tab_screen.dart';

class AdminMainTabViewScreen extends StatefulWidget {
  const AdminMainTabViewScreen({super.key});

  @override
  State<AdminMainTabViewScreen> createState() => _AdminMainTabViewScreenState();
}

class _AdminMainTabViewScreenState extends State<AdminMainTabViewScreen>
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
        AdminDashboardTabScreen(),
        NewOrderListScreen(),
        FavoritesTabScreen(),
        AdminMyAccountTabScreen()
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
                  text: "Dashboard",
                ),
                Tab(
                  icon: Image.asset(
                    "assets/img/cart_tab.png",
                    color: selectTab == 1 ? TColor.active : TColor.inactive,
                    width: 30,
                    height: 30,
                  ),
                  text: "New Order",
                ),
                Tab(
                  icon: Image.asset(
                    "assets/img/fav_tab.png",
                    color: selectTab == 2 ? TColor.active : TColor.inactive,
                    width: 30,
                    height: 30,
                  ),
                  text: "Items",
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
