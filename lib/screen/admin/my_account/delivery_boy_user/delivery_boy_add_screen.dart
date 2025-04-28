import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class DeliveryBoyAddScreen extends StatefulWidget {
  final bool isEdit;
  final Map? editObj;
  const DeliveryBoyAddScreen({super.key, this.isEdit = false, this.editObj});

  @override
  State<DeliveryBoyAddScreen> createState() => _DeliveryBoyAddScreenState();
}

class _DeliveryBoyAddScreenState extends State<DeliveryBoyAddScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  final countryPicker = const FlCountryCodePicker();
  late CountryCode countryCode;
  TextEditingController txtMobile = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isEdit && widget.editObj != null) {
      txtName.text = widget.editObj?["name"]?.toString() ?? "";
      txtEmail.text = widget.editObj?["email"]?.toString() ?? "";
      txtMobile.text = widget.editObj?["mobile"]?.toString() ?? "";
      var code = (widget.editObj?["mobile_code"]?.toString() ?? "+91");
      countryCode = countryPicker.countryCodes.firstWhere((item) => item.dialCode == code);
    }else{
countryCode =
        countryPicker.countryCodes.firstWhere((item) => item.name == "India");
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
          widget.isEdit ? "Edit Delivery Boy" : "Add Delivery Boy",
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
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Name",
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

              SizedBox(height: 15,),
Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Mobile Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.secondaryText,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final code =
                            await countryPicker.showPicker(context: context);

                        if (code != null) {
                          countryCode = code;
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: TColor.secondaryText, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          " ${countryCode.dialCode}",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: txtMobile,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Ex: 9876543210",
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                controller: txtEmail,
                hintText: "",
                keyboardType: TextInputType.emailAddress,
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
      mdShowAlert(Globs.appName, "Please enter name", () {});
      return;
    }

    if (txtMobile.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter mobile number", () {});
      return;
    }

    if (txtEmail.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter email address", () {});
      return;
    }
    endEditing();
    apiCallAddUpdate(widget.isEdit
        ? {
            'user_id': widget.editObj?["user_id"].toString() ?? "",
            'name': txtName.text,
            'mobile': txtMobile.text,
            'email': txtEmail.text,
            'mobile_code': countryCode.dialCode
          }
        : {'name': txtName.text,
            'mobile': txtMobile.text,
            'email': txtEmail.text,
            'mobile_code': countryCode.dialCode,});
  }

  //TODO: ApiCalling
  void apiCallAddUpdate(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      widget.isEdit
          ? SVKey.adminDeliveryBoyUserUpdate
          : SVKey.adminDeliveryBoyUserAdd,
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
