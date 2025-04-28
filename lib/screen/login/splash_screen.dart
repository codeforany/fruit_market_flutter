import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/admin/admin_main_tab_view_screen.dart';
import 'package:fruitmarket/screen/delivery_boy/delivery_boy_main_tab_view_screen.dart';
import 'package:fruitmarket/screen/login/onboarding_screen.dart';
import 'package:fruitmarket/screen/tabview/main_tab_view_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    load();
  }

  void load() async {
    await Future.delayed(const Duration(seconds: 3));
    loadNextScreen();
  }

  void loadNextScreen() {
    if (Globs.udValueBool(Globs.userLogin)) {
      ServiceCall.userObj = Globs.udValue(Globs.userPayload);
      ServiceCall.userType = ServiceCall.userObj[KKey.userType] as int? ?? 1;
     

      if (ServiceCall.userType == 3) {
        //Owner App (Admin)
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminMainTabViewScreen()),
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
    } else {
      context.push(OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: context.height,
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/img/splash_bottom.png",
              width: double.maxFinite,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.height * 0.15),
            child: Text(
              Globs.appName,
              style: TextStyle(
                color: TColor.whiteText,
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
