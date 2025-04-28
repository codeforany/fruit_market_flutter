import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/screen/cart/add_card_screen.dart';

class CheckOutScreen extends StatefulWidget {
  final Map addressObj;
  final String price;
  const CheckOutScreen({super.key, required this.addressObj, required this.price});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.whiteText,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.primaryText,
          ),
        ),
        title: Text(
          "Total Bill: \$${ widget.price }",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       "assets/img/shop.png",
              //       width: 25,
              //       height: 25,
              //       fit: BoxFit.contain,
              //     ),
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Expanded(
              //         child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "Organic Fruit Shop",
              //           style: TextStyle(
              //             color: TColor.primaryText,
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         Text(
              //           "2 Items : Delivery Time  30 Min",
              //           style: TextStyle(
              //             color: TColor.secondaryText,
              //             fontSize: 12,
              //           ),
              //         ),
              //       ],
              //     ))
              //   ],
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/home_location.png",
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home Address",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${ widget.addressObj["address"].toString()},${widget.addressObj["city"].toString() },${widget.addressObj["zip_code"].toString()}",
                          maxLines: 2,
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  color: Colors.black26,
                  height: 1,
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Credit/Debit Cards",
              //       style: TextStyle(
              //         color: TColor.primaryText,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         context.push( const AddCardScreen() );
              //       },
              //       child: Text(
              //         "ADD NEW CARD",
              //         style: TextStyle(
              //           color: Colors.green,
              //           fontSize: 12,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // ListView.separated(
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           "assets/img/card.png",
              //           width: 25,
              //           height: 25,
              //           fit: BoxFit.contain,
              //         ),
              //         SizedBox(
              //           width: 15,
              //         ),
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "************4356",
              //                 style: TextStyle(
              //                   color: TColor.secondaryText,
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //               ),
              //               Text(
              //                 "code for any",
              //                 maxLines: 2,
              //                 style: TextStyle(
              //                   color: TColor.secondaryText,
              //                   fontSize: 10,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              //   separatorBuilder: (context, index) => Divider(
              //     color: Colors.black26,
              //     height: 1,
              //   ),
              //   itemCount: 1,
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              // Text(
              //   "Save and Pay via cards",
              //   maxLines: 1,
              //   style: TextStyle(
              //     color: TColor.secondaryText,
              //     fontSize: 10,
              //   ),
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Image.asset(
              //       "assets/img/mscard.png",
              //       width: 50,
              //       height: 30,
              //     ),
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Image.asset(
              //       "assets/img/ms1card.png",
              //       width: 50,
              //       height: 30,
              //     ),
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Image.asset(
              //       "assets/img/visa.png",
              //       width: 50,
              //       height: 30,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              // Text(
              //   "Wallet Method",
              //   style: TextStyle(
              //     color: TColor.primaryText,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // ListView.separated(
              //   physics: NeverScrollableScrollPhysics(),
              //   padding: const EdgeInsets.symmetric(vertical: 8),
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return SizedBox(
              //       height: 55,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Image.asset(
              //             "assets/img/paypal.png",
              //             width: 40,
              //             height: 40,
              //             fit: BoxFit.contain,
              //           ),
              //           SizedBox(
              //             width: 15,
              //           ),
              //           Expanded(
              //             child: Text(
              //               "Pay Pal",
              //               style: TextStyle(
              //                 color: TColor.primaryText,
              //                 fontSize: 14,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              //   separatorBuilder: (context, index) => Divider(
              //     color: Colors.black26,
              //     height: 1,
              //   ),
              //   itemCount: 3,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          child: RoundButton(title: "PAY NOW", onPressed: () {

              apiCallingOrderPlace({
                "payment_type":"1",
                "address": "${widget.addressObj["address"].toString()},${ widget.addressObj["city"].toString() }",
                "lati": widget.addressObj["lati"].toString(),
                "longi": widget.addressObj["longi"].toString(),
                "zip_code": widget.addressObj["zip_code"].toString(),

              });

          }),
        ),
      ),
    );
  }

    void apiCallingOrderPlace(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.orderPlace, isTokenApi: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});

        
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }
}
