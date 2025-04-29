import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/delivery_boy/orders/delivery_boy_order_details_screen.dart';

class DeliveryBoyNewOrdersTabScreen extends StatefulWidget {
  const DeliveryBoyNewOrdersTabScreen({super.key});

  @override
  State<DeliveryBoyNewOrdersTabScreen> createState() =>
      _DeliveryBoyNewOrdersTabScreenState();
}

class _DeliveryBoyNewOrdersTabScreenState
    extends State<DeliveryBoyNewOrdersTabScreen> {
  List newOrderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallingOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Container(),
        title: Text(
          "New Orders",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Color(0xfffdfdfd),
      body: newOrderList.isEmpty
          ? Center(
              child: Text(
                "No New Order",
                style: TextStyle(
                  color: TColor.placeholder,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemBuilder: (context, index) {
                var obj = newOrderList[index] as Map? ?? {};

                return InkWell(
                  onTap: () async {
                    await context.push(DeliveryBoyOrderDetailsScreen(obj: obj));
                    apiCallingOrderList();
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: obj["image"].toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    obj["item_name"],
                                    style: TextStyle(
                                      color: TColor.primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  obj["created_date"].toString().displayDate(
                                      displayFormat: "d MMM yyyy hh:mm aa"),
                                  style: TextStyle(
                                    color: TColor.secondaryText,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "QTY:",
                                  style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  " ${obj["qty"]} X 1 ${obj["unit_name"]}",
                                  style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  getStatusName(obj),
                                  style: TextStyle(
                                    color: getStatusColor(obj),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Divider(
                  height: 1,
                  color: Colors.black26,
                ),
              ),
              itemCount: newOrderList.length,
            ),
    );
  }

  //TODO: Action

  String getStatusName(Map obj) {
    switch (obj["order_status"].toString()) {
      case "1":
        return "New";
      case "2":
        return "Ready";
      case "3":
        return "Out for Delivery";
      case "4":
        return "Delivered";
      case "5":
        return "User Cancel";
      case "6":
        return "Delivery Boy Cancel";
      case "7":
        return "Order Reject";

      default:
        return "New";
    }
  }

  Color getStatusColor(Map obj) {
    switch (obj["order_status"].toString()) {
      case "1":
        return Colors.blueAccent;
      case "2":
        return Colors.amber;
      case "3":
        return Colors.orange;
      case "4":
        return Colors.green;
      case "5":
        return Colors.red;
      case "6":
        return Colors.red;
      case "7":
        return Colors.red;

      default:
        return Colors.blue;
    }
  }

  //TODO: ApiCalling

  void apiCallingOrderList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.deliveryNewOrderList, isTokenApi: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "1") {
        newOrderList = responseObj[KKey.payload] as List? ?? [];
        if (mounted) {
          setState(() {});
        }
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }
}
