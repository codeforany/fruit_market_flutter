import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class AdminUnitAddScreen extends StatefulWidget {
  final bool isEdit;
  final Map? obj;

  const AdminUnitAddScreen({super.key, this.isEdit = false,  this.obj});

  @override
  State<AdminUnitAddScreen> createState() => _AdminUnitAddScreenState();
}

class _AdminUnitAddScreenState extends State<AdminUnitAddScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtValue = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isEdit) {
      txtName.text = widget.obj?["unit_name"]?.toString() ?? "";
      txtValue.text = widget.obj?["unit_value"]?.toString() ?? "";
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
          widget.isEdit ? "Edit Unit" : "Add Unit",
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
                  "Unit Name",
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
                  "Unit Value(Lower Unit)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                controller: txtValue,
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
      mdShowAlert(Globs.appName, "Please enter unit name", () {});
      return;
    }

    if (txtValue.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter unit value", () {});
      return;
    }
    endEditing();
    apiCallAddUpdate(widget.isEdit
        ? {
            'unit_id': widget.obj?["unit_id"].toString() ?? "",
            'unit_name': txtName.text,
            'unit_value': txtValue.text
          }
        : {'unit_name': txtName.text, 'unit_value': txtValue.text});
  }

  //TODO: ApiCalling
  void apiCallAddUpdate(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      widget.isEdit ? SVKey.adminUnitUpdate : SVKey.adminUnitAdd,
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
