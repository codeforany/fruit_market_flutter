import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class AdminItemNutritionEdit extends StatefulWidget {
  final Map obj;
  const AdminItemNutritionEdit({super.key, required this.obj});

  @override
  State<AdminItemNutritionEdit> createState() => _AdminItemNutritionEditState();
}

class _AdminItemNutritionEditState extends State<AdminItemNutritionEdit> {

  TextEditingController txtName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtName.text = widget.obj["name"].toString();
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
          "Edit Nutrition",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [

          SizedBox(
            height: 30,
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundTextfield(
              hintText: "Enter Nutrition Name",
              controller: txtName,
            ),
          ),

          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundButton(
                title: "UPDATE",
                onPressed: () {
                  if (txtName.text.isEmpty) {
                    mdShowAlert(Globs.appName, "please enter nutrition name", () {});
                    return;
                  }

                 
                  apiCallAddUpdate({
                    'nutrition_id': widget.obj["nutrition_id"].toString(),
                    'name': txtName.text
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
      SVKey.adminItemNutritionUpdate,
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
