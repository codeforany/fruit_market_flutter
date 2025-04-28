import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class AdminItemNutritionAdd extends StatefulWidget {
  final Map obj;
  const AdminItemNutritionAdd({super.key, required this.obj});

  @override
  State<AdminItemNutritionAdd> createState() => _AdminItemNutritionAddState();
}

class _AdminItemNutritionAddState extends State<AdminItemNutritionAdd> {
  List nutritionArr = [];
  TextEditingController txtName = TextEditingController();

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
          "Nutrition",
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
                  child: RoundTextfield(
                    hintText: "Enter Nutrition Name",
                    controller: txtName,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (txtName.text.isEmpty) {
                      mdShowAlert(
                          Globs.appName, "Please enter nutrition name", () {});
                      return;
                    }

                    setState(() {
                      nutritionArr.add(txtName.text);
                      txtName.text = "";
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: TColor.active,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: nutritionArr.isEmpty
                ? Center(
                    child: Text(
                      "Add Nutrition",
                      style: TextStyle(
                        color: TColor.placeholder,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              nutritionArr[index],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            IconButton(
                              onPressed: () {
                                nutritionArr.remove(nutritionArr[index]);
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: Colors.black26,
                        height: 1,
                      ),
                    ),
                    itemCount: nutritionArr.length,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 26, left: 20, right: 20),
            child: RoundButton(
                title: "ADD",
                onPressed: () {
                  if (nutritionArr.isEmpty) {
                    mdShowAlert(Globs.appName, "add nutrition value", () {});
                    return;
                  }


                  var sendVal = nutritionArr.map( (name) {
                    return {'name': name};
                  } ).toList();

                  apiCallAddUpdate({
                    'item_id': widget.obj["item_id"].toString(),
                    'nutrition_list' : jsonEncode(sendVal)
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
      SVKey.adminItemNutritionAdd,
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
}
