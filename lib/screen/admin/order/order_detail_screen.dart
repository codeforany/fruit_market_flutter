import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/popup_layout.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/screen/admin/my_account/delivery_boy_user/delivery_boy_list_screen.dart';
import 'package:fruitmarket/screen/admin/order/reason_text_popup.dart';

class OrderDetailScreen extends StatefulWidget {
  final Map obj;
  const OrderDetailScreen({super.key, required this.obj});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
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
              Text(
                "Delivery Information:",
                style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
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
                              widget.obj["payment_type"] == "1"
                                  ? "COD"
                                  : "Online",
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
              if (widget.obj["order_status"] == 0)
                Row(
                  children: [
                    Expanded(
                      child: RoundButton(
                        title: "Accept",
                        onPressed: () {
                          apiCallingAcceptReject({
                            'item_order_id':
                                widget.obj["item_order_id"].toString(),
                            'is_accept': "1",
                            'reason': ""
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: RoundButton(
                        title: "Reject",
                        type: RoundButtonType.secondary,
                        onPressed: () {
                          Navigator.push(context, PopupLayout(
                              child: ReasonTextPopup(didSubmit: (reason) {
                            apiCallingAcceptReject({
                              'item_order_id':
                                  widget.obj["item_order_id"].toString(),
                              'is_accept': "2",
                              'reason': reason
                            });
                          })));
                        },
                      ),
                    )
                  ],
                ),
              if (widget.obj["order_status"] == 1 && widget.obj["status"] == 0)
                InkWell(
                  onTap: () async {
                    await context.push(DeliveryBoyListScreen(
                      isPicker: true,
                      didSelect: (selectUser) {
                        dbObj = selectUser;
                      },
                    ));

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: TColor.primary, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            dbObj == null
                                ? "Select Delivery Boy"
                                : "${dbObj!["name"] ?? ""}",
                            style: TextStyle(
                              color: dbObj == null
                                  ? TColor.placeholder
                                  : TColor.primaryText,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: TColor.primary,
                        )
                      ],
                    ),
                  ),
                ),
              if (widget.obj["order_status"] == 1 && widget.obj["status"] == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: RoundButton(
                      title: "Assign",
                      onPressed: () {
                        if (dbObj == null) {
                          mdShowAlert(Globs.appName,
                              "Please select Delivery Boy", () {});
                              return;
                        }

                        apiCallingAssign({
                          'delivery_boy_id': dbObj!["user_id"].toString(),
                          'order_id': widget.obj["order_id"].toString()
                        });
                      }),
                )
            ],
          ),
        ),
      ),
    );
  }

  String getStatusName(Map obj) {
    switch (obj["order_status"].toString()) {
      case "1":
        return "Order Accept";
      case "2":
        return "Wait for Delivery";
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
        return "New Order";
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
  void apiCallingAcceptReject(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.adminOrderItemAcceptReject,
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
