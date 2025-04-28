//flutter create --org com.codeforany fruitmarket

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/my_http_overrides.dart';
import 'package:fruitmarket/common/socket_manager.dart';
import 'package:fruitmarket/screen/login/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? prefs;

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  SocketManager.shared.initSocket();

  runApp(const MyApp());
  configLoading();
}

void configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 5.0
      ..progressColor = TColor.primaryText
      ..backgroundColor = TColor.primary
      ..indicatorColor = Colors.white
      ..textColor = TColor.primaryText
      ..userInteractions = false
      ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Globs.appName,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
       fontFamily: "Poppins",
       scaffoldBackgroundColor: TColor.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          color: TColor.primary,
          elevation: 0,
        )
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

