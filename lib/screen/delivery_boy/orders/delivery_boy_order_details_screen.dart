import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/location_helper.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';

class DeliveryBoyOrderDetailsScreen extends StatefulWidget {
  final Map obj;
  const DeliveryBoyOrderDetailsScreen({super.key, required this.obj});

  @override
  State<DeliveryBoyOrderDetailsScreen> createState() =>
      _DeliveryBoyOrderDetailsScreenState();
}

class _DeliveryBoyOrderDetailsScreenState
    extends State<DeliveryBoyOrderDetailsScreen> {
  Map? dbObj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.whiteText,
          ),
        ),
        title: Text(
          "Order Detail",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Color(0xfffdfdfd),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Information:",
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.obj["payment_type"] == 1 ? "COD" : "PREPAID",
                    style: TextStyle(
                        color: widget.obj["payment_type"] == 1
                            ? Colors.orange
                            : Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                widget.obj["name"],
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 15,
                ),
              ),
              Text(
                "Mobile :${widget.obj["mobile_code"]} ${widget.obj["mobile"]}",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Shipping Information:",
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${widget.obj["address"]}",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 15,
                ),
              ),
              Text(
                "Postal Code : ${widget.obj["zip_code"]}",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Order Information:",
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.obj["image"].toString(),
                      width: 80,
                      height: 80,
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
                                widget.obj["item_name"],
                                style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              widget.obj["created_date"].toString().displayDate(
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
                              " ${widget.obj["qty"]} X ${widget.obj["unit_name"]}",
                              style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 12,
                              ),
                            ),
                            Spacer(),
                            Text(
                              getStatusName(widget.obj),
                              style: TextStyle(
                                color: getStatusColor(widget.obj),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${widget.obj["item_amount"]} X ${widget.obj["qty"]} ",
                              style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 12,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${widget.obj["pay_amount"]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Payment Type:",
                              style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 12,
                              ),
                            ),
                            Spacer(),
                            Text(
                              widget.obj["payment_type"] == 1
                                  ? "Cash On Delivery"
                                  : "Prepaid",
                              style: TextStyle(
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
              SizedBox(
                height: 25,
              ),
              if (widget.obj["status"] == 2)
                RoundButton(
                  title: "Out For Delivery",
                  onPressed: () {
                    apiCallingOutForDelivery({
                      'order_id': widget.obj["order_id"].toString(),
                    });
                  },
                ),
              if (widget.obj["order_status"] == 3)
                Row(
                  children: [
                    Expanded(
                      child: RoundButton(
                        title: "Delivered",
                        onPressed: () {

                          mdShowAlertTowButton(
                              Globs.appName, "Are you sura order are delivered?",
                              () {
                            apiCallingOrderDelivered({
                              'order_id': widget.obj["order_id"].toString(),
                              'item_order_id':
                                  widget.obj["item_order_id"].toString(),
                              'latitude':
                                  ((LocationHelper.singleton.lastLocation)
                                              ?.latitude)
                                          ?.toString() ??
                                      "0.0",
                              'longitude':
                                  ((LocationHelper.singleton.lastLocation)
                                              ?.longitude)
                                          ?.toString() ??
                                      "0.0",
                            });
                          }, () {});

                          
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: RoundButton(
                        title: "Cancel",
                        type: RoundButtonType.line,
                        onPressed: () {
                          mdShowAlertTowButton(
                              Globs.appName, "Are you sura order are cancel?",
                              () {
                            apiCallingOrderDelivereCancel({
                              'item_order_id':
                                  widget.obj["item_order_id"].toString(),
                              'latitude':
                                  ((LocationHelper.singleton.lastLocation)
                                              ?.latitude)
                                          ?.toString() ??
                                      "0.0",
                              'longitude':
                                  ((LocationHelper.singleton.lastLocation)
                                              ?.longitude)
                                          ?.toString() ??
                                      "0.0",
                              'reason': 'user are not accept delivery'
                            });
                          }, () {});
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

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
  void apiCallingOutForDelivery(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.deliveryBoyOrderOutForDelivery,
        isTokenApi: true, withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "1") {
        widget.obj["status"] = 3;
        setState(() {});
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {
          context.pop();
        });
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }

  void apiCallingOrderDelivered(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.deliveryBoyOrderDelivered,
        isTokenApi: true, withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "1") {
        widget.obj["order_status"] = 4;
        setState(() {});
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {
          context.pop();
        });
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }

  void apiCallingOrderDelivereCancel(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.deliveryBoyOrderDeliverCancel,
        isTokenApi: true, withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "1") {
        widget.obj["order_status"] = 6;
        setState(() {});
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {
          context.pop();
        });
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }

  void apiCallingAssign(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.adminDeliveryBoyUserAssignOrder,
        isTokenApi: true, withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "1") {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {
          context.pop();
        });
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }
}
