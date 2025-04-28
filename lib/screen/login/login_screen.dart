import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common_widgets/icon_round_button.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/screen/login/mobile_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: double.maxFinite,
          ),
          Image.asset(
            "assets/img/login_img.png",
            width: context.width * 0.6,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Fruit Market",
            style: TextStyle(
              color: TColor.primary,
              fontSize: 50,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: RoundButton(
                title: "Enter Your Mobile Number",
                type: RoundButtonType.line,
                alignment: Alignment.centerLeft,
                onPressed: () {
                  context.push( const MobileLoginScreen() );
                }),
          ),
          Spacer(),
          Text(
            "OR",
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: IconRoundButton(
                    title: "Log in With",
                    icon: "assets/img/google.png",
                    onPressed: () {},
                  ),
                ),

                SizedBox(width: 15,),

                  Expanded(
                  child: IconRoundButton(
                    title: "Log in With",
                    icon: "assets/img/fb.png",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Spacer()
        ],
      )),
    );
  }
}
