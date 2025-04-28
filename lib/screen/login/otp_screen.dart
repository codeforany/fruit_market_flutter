import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/socket_manager.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/screen/admin/admin_main_tab_view_screen.dart';
import 'package:fruitmarket/screen/delivery_boy/delivery_boy_main_tab_view_screen.dart';
import 'package:fruitmarket/screen/login/name_address_screen.dart';
import 'package:fruitmarket/screen/tabview/main_tab_view_screen.dart';

import '../../common/service_call.dart';

class OtpScreen extends StatefulWidget {
  final Map<String, dynamic> passValue;
  const OtpScreen({super.key, required this.passValue});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = "";

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter The 6 digit code that was\nsend to your Mobile Number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: OtpTextField(
                  numberOfFields: 6,
                  fieldHeight: 50,
                  borderColor: TColor.primary,
                  fieldWidth: 50,
                  filled: true,
                  focusedBorderColor: TColor.primary,
                  enabledBorderColor: Color(0xffF0F0F0),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  borderRadius: BorderRadius.circular(25),
                  fillColor: Color(0xffF0F0F0),
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    otpCode = code;
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    otpCode = verificationCode;
                    clkVerify();
                  }, // end onSubmit
                ),
              ),
              RoundButton(
                  title: "VERIFY",
                  onPressed: () {
                    clkVerify();
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      apiCallingLogin(widget.passValue);
                    },
                    child: Text(
                      "Resend Again?",
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  //TODO: Action
  void clkVerify() {
    if (otpCode.length != 6) {
      mdShowAlert(Globs.appName, "Please enter valid otp", () {});
      return;
    }
    endEditing();
    widget.passValue["otp_code"] = otpCode;
    apiCallingVerifyLogin(widget.passValue);
  }

  //TODO: Api Calling

  void apiCallingVerifyLogin(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.verifyOtp,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          ServiceCall.userObj = responseObj[KKey.payload] as Map? ?? {};
          ServiceCall.userType =
              ServiceCall.userObj[KKey.userType] as int? ?? 1;
          Globs.udSet(ServiceCall.userObj, Globs.userPayload);
          Globs.udBoolSet(true, Globs.userLogin);

          if (ServiceCall.userType == 3) {
            //Owner App (Admin)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminMainTabViewScreen()),
                (route) => true);
          } else if (ServiceCall.userType == 2) {
            //Delivery Boy App
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => DeliveryBoyMainTabViewScreen()),
                (route) => true);
          } else {
            // End User App
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainTabViewScreen()),
                (route) => true);
          }

          // mdShowAlert(
          //     Globs.appName, "User Login Successfully", () {
          //       context.push(const NameAddressScreen());
          //     });
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

  void apiCallingLogin(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.login,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(Globs.appName, "Otp send successfully", () {});
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
