import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class AdminCategoryAddScreen extends StatefulWidget {
  final bool isEdit;
  final Map obj;

  const AdminCategoryAddScreen(
      {super.key, this.isEdit = false, required this.obj});

  @override
  State<AdminCategoryAddScreen> createState() => _AdminCategoryAddScreenState();
}

class _AdminCategoryAddScreenState extends State<AdminCategoryAddScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSubtitle = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isEdit) {
      txtName.text = widget.obj["cat_name"]?.toString() ?? "";
      txtSubtitle.text = widget.obj["subtitle"]?.toString() ?? "";
    }
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
          widget.isEdit ? "Edit Category" : "Add Category",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Category Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                controller: txtName,
                hintText: "",
              ),
             
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Subtitle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                controller: txtSubtitle,
                hintText: "",
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                  title: widget.isEdit ? "UPDATE" : "ADD",
                  onPressed: () {
                    clkSubmit();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Action
  void clkSubmit() {
    if (txtName.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter category name", () {});
      return;
    }

    if (txtSubtitle.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter category subtitle", () {});
      return;
    }
    endEditing();
    apiCallAddUpdate(widget.isEdit
        ? {
            'cat_id': widget.obj["cat_id"].toString(),
            'main_cat_id': widget.obj["main_cat_id"].toString(),
            'cat_name': txtName.text,
            'subtitle': txtSubtitle.text
          }
        : {
            'main_cat_id': widget.obj["main_cat_id"].toString(),
            'cat_name': txtName.text,
            'subtitle': txtSubtitle.text
          });
  }

  //TODO: ApiCalling
  void apiCallAddUpdate(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      widget.isEdit
          ? SVKey.adminCategoryUpdate
          : SVKey.adminCategoryAdd,
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
