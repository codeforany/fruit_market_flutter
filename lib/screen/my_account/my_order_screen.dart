import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/my_account/my_order_row.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List orderArr = [
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiList();
  }

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
          "My Orders",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        itemBuilder: (context, index) {
          var obj = orderArr[index];

          return MyOrderRow(obj: obj, onPressed: () {});
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            color: Colors.black26,
            height: 1,
          ),
        ),
        itemCount: orderArr.length,
      ),
    );
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.myOrdersList, isTokenApi: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        orderArr = responseObj[KKey.payload] as List? ?? [];

        if (mounted) {
          setState(() {
            
          });
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
