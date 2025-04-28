import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common/socket_manager.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/screen/login/otp_screen.dart';
import 'dart:io' show Platform;

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final countryPicker = const FlCountryCodePicker();
  late CountryCode countryCode;
  TextEditingController txtMobile = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryCode =
        countryPicker.countryCodes.firstWhere((item) => item.name == "India");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.primaryText,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
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
            SizedBox(
              height: 60,
            ),
            RoundButton(
                title: "VERIFY",
                onPressed: () {
                  clkLogin();
                })
          ],
        ),
      )),
    );
  }

  //TODO: Action
  void clkLogin() {
    if (txtMobile.text.length < 10) {
      mdShowAlert(Globs.appName, "Please enter valid mobile number", () {});
      return;
    }
    endEditing();
    apiCallingLogin({
      'mobile_code': countryCode.dialCode,
      "mobile": txtMobile.text,
      "os_type": Platform.isAndroid ? "a" : "i",
      "push_token": "",
      "socket_id": SocketManager.shared.socket?.id ?? ""
    });
  }

  //TODO: Api Calling

  void apiCallingLogin(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.login,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          context.push(OtpScreen(
            passValue: parameter,
          ));
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
