import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/location_helper.dart';
import 'package:fruitmarket/screen/delivery_boy/dashboard/delivery_boy_dashboard_tab_screen.dart';
import 'package:fruitmarket/screen/delivery_boy/my_account/deliery_boy_my_account_tab_view_screen.dart';
import 'package:fruitmarket/screen/delivery_boy/new_orders/delivery_boy_new_order_tab_screen.dart';
import 'package:fruitmarket/screen/delivery_boy/orders/delivery_boy_my_orders_tab_screen.dart';

class DeliveryBoyMainTabViewScreen extends StatefulWidget {
  const DeliveryBoyMainTabViewScreen({super.key});

  @override
  State<DeliveryBoyMainTabViewScreen> createState() => _DeliveryBoyMainTabViewScreenState();
}

class _DeliveryBoyMainTabViewScreenState extends State<DeliveryBoyMainTabViewScreen>
    with SingleTickerProviderStateMixin {
  int selectTab = 0;
  TabController? controller;

  @override
  void initState() {

    LocationHelper.shared().startInit();

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
        DeliveryBoyDashboardTabScreen(),
        DeliveryBoyNewOrdersTabScreen(),
        DeliveryBoyMyOrdersTabScreen(),
        DeliveryBoyMyAccountTabScreen()
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
                  text: "New Orders",
                ),
                Tab(
                  icon: Image.asset(
                    "assets/img/fav_tab.png",
                    color: selectTab == 2 ? TColor.active : TColor.inactive,
                    width: 30,
                    height: 30,
                  ),
                  text: "My Orders",
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
