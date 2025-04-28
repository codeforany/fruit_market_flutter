

import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_drop_down_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class AdminItemPriceScreen extends StatefulWidget {
  final Map obj;
  const AdminItemPriceScreen({super.key, required this.obj});

  @override
  State<AdminItemPriceScreen> createState() => _AdminItemPriceScreenState();
}

class _AdminItemPriceScreenState extends State<AdminItemPriceScreen> {
  List unitArr = [];
  Map? selectUnit;
  TextEditingController txtPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallUnitList({});
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
          "Price",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: RoundDropDownButton(
                      hintText: "Select Unit",
                      displayKey: "unit_name",
                      itemsArr: unitArr,
                      selectVal: selectUnit,
                      didChanged: (newVal) {
                        selectUnit = newVal;
                        setState(() {});
                      }),
                ),

                SizedBox(width: 15,),
                Expanded(
                  child: RoundTextfield(
                    hintText: "Enter Price",
                    controller: txtPrice,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 26, left: 20, right: 20),
            child: RoundButton(
                title: "ADD",
                onPressed: () {
                  if (selectUnit == null) {
                    mdShowAlert(Globs.appName, "please price unit", () {});
                    return;
                  }

                  if (txtPrice.text.isEmpty) {
                    mdShowAlert(Globs.appName, "please enter price", () {});
                    return;
                  }
                  apiCallAddUpdate({
                    'item_id': widget.obj["item_id"].toString(),
                    'unit_id': selectUnit!["unit_id"].toString(),
                    'amount': txtPrice.text
                  });
                }),
          )
        ],
      ),
    );
  }

  //TODO: ApiCalling
  void apiCallAddUpdate(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminItemPriceAdd,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          context.pop();
        } else {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
        }
      },
      failure: (error) async {
        Globs.hideHUD();
        mdShowAlert(Globs.appName, error.toString(), () {});
      },
    );
  }

  void apiCallUnitList(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminUnitList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          unitArr = responseObj[KKey.payload] as List? ?? [];

          if (mounted) {
            setState(() {});
          }
        } else {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
        }
      },
      failure: (error) async {
        Globs.hideHUD();
        mdShowAlert(Globs.appName, error.toString(), () {});
      },
    );
  }
}
