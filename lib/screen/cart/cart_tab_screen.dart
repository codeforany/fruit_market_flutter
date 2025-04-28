import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/screen/cart/cart_row.dart';
import 'package:fruitmarket/screen/cart/check_out_screen.dart';
import 'package:fruitmarket/screen/my_account/address_list_screen.dart';

class CartTabScreen extends StatefulWidget {
  const CartTabScreen({super.key});

  @override
  State<CartTabScreen> createState() => _CartTabScreenState();
}

class _CartTabScreenState extends State<CartTabScreen> {
  Map? selectAddress;
  List cartArr = [];
  double total = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Container(),
        leadingWidth: 15,
        title: Text(
          "Shopping Cart",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: cartArr.isEmpty
          ? Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(
                  color: TColor.placeholder,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: TColor.secondaryText,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          selectAddress == null
                              ? "pick address"
                              : (selectAddress?["address"].toString() ?? ""),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(AddressListScreen(
                            isPicker: true,
                            didSelect: (sObj) {
                              selectAddress = sObj;
                              if (mounted) {
                                setState(() {});
                              }
                            },
                          ));
                        },
                        child: Text(
                          "Change Address",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var catObj = cartArr[index] as Map? ?? {};
                      var cartListArr = catObj["cart_list"] as List? ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color(0xffE6E6E6),
                            ),
                            child: Text(
                              catObj["main_cat_name"].toString(),
                              style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var obj = cartListArr[index];
                              return CartRow(
                                obj: obj,
                                onPressed: () {},
                                onAddQTY: () {
                                  var qty =
                                      int.tryParse(obj["qty"].toString()) ?? 1;
                                  qty = qty + 1;
                                  apiCallingUpdate({
                                    'cart_id': obj["cart_id"].toString(),
                                    'item_id': obj["item_id"].toString(),
                                    'qty': qty.toString()
                                  });
                                },
                                onSubQTY: () {
                                  var qty =
                                      int.tryParse(obj["qty"].toString()) ?? 1;

                                  if (qty == 1) {
                                    apiCallingDelete({
                                      'cart_id': obj["cart_id"].toString(),
                                      'item_id': obj["item_id"].toString()
                                    });
                                  } else {
                                    qty = qty - 1;
                                    apiCallingUpdate({
                                      'cart_id': obj["cart_id"].toString(),
                                      'item_id': obj["item_id"].toString(),
                                      'qty': qty.toString()
                                    });
                                  }
                                },
                                onDelete: () {
                                  apiCallingDelete({
                                    'cart_id': obj["cart_id"].toString(),
                                    'item_id': obj["item_id"].toString()
                                  });
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.black26,
                              height: 1,
                            ),
                            itemCount: cartListArr.length,
                          )
                        ],
                      );
                    },
                    itemCount: cartArr.length,
                  ),
                )
              ],
            ),
      bottomNavigationBar: cartArr.isEmpty
          ? Container(
              height: 60,
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              child: Row(
                children: [
                  Text(
                    "Total: ",
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  RoundButton(
                      title: "Place Order",
                      width: 140,
                      height: 40,
                      onPressed: () async {
                        if (selectAddress == null) {
                          mdShowAlert(
                              Globs.appName, "Please select address", () {});
                          return;
                        }

                        await context.push(CheckOutScreen(
                          addressObj: selectAddress!,
                          price: total.toStringAsFixed(2) ,
                        ));

                        apiCallingList();
                      })
                ],
              ),
            ),
    );
  }

  //TODO: ApiCalling

  void apiCallingList() {
    Globs.showHUD();

    ServiceCall.post({}, SVKey.cartList, isTokenApi: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        cartArr = responseObj[KKey.payload] as List? ?? [];

        var tVal = 0.0;

        cartArr.forEach((obj) {
          var tempVal = 0.0;
          (obj["cart_list"] as List? ?? []).forEach((cObj) {
            tempVal += (double.tryParse(cObj["qty"].toString()) ?? 0.0) *
                (double.tryParse(cObj["amount"].toString()) ?? 0.0);
          });
          tVal += tempVal;
        });

        if (mounted) {
          total = tVal;
          setState(() {});
        }
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (error) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, error.toString(), () {});
    });
  }

  void apiCallingUpdate(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.cartQTYUpdate, isTokenApi: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        apiCallingList();
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (error) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, error.toString(), () {});
    });
  }

  void apiCallingDelete(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.cartDelete, isTokenApi: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        apiCallingList();
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (error) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, error.toString(), () {});
    });
  }
}
