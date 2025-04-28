import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/login/login_screen.dart';
import 'package:fruitmarket/screen/my_account/my_order_screen.dart';
import 'package:fruitmarket/screen/my_account/setting_row.dart';
import 'package:fruitmarket/screen/my_account/settings_screen.dart';

class DeliveryBoyMyAccountTabScreen extends StatefulWidget {
  const DeliveryBoyMyAccountTabScreen({super.key});

  @override
  State<DeliveryBoyMyAccountTabScreen> createState() => _DeliveryBoyMyAccountTabScreenState();
}

class _DeliveryBoyMyAccountTabScreenState extends State<DeliveryBoyMyAccountTabScreen> {
  List menuArr = [
    {'name': 'Settings', 'ico': 'assets/img/settings.png', 'order': '3'},
    {'name': 'Rate us', 'ico': 'assets/img/rate_us.png', 'order': '5'},
    {'name': 'Refer a Friend', 'ico': 'assets/img/refer.png', 'order': '6'},
    {'name': 'Help ', 'ico': 'assets/img/help.png', 'order': '7'},
    {'name': 'Log Out', 'ico': 'assets/img/logout.png', 'order': '8'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.width,
            color: TColor.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                55,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2,
                                )
                              ]),
                          child: Image.asset(
                            "assets/img/user_placeholder.png",
                            width: double.maxFinite,
                            height: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/img/edit.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  ServiceCall.userObj["name"].toString(),
                  style: TextStyle(
                    color: TColor.whiteText,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  ServiceCall.userObj["email"].toString(),
                  style: TextStyle(
                    color: TColor.whiteText,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                var obj = menuArr[index];
                return SettingRow(
                    title: obj['name'].toString(),
                    icon: obj['ico'].toString(),
                    onPressed: () {
                      switch (obj["order"].toString()) {
                        case "1":
                          context.push(const MyOrderScreen());
                          break;
                        case "2":
                          break;
                        case "3":
                          context.push(const SettingsScreen());
                          break;
                        case "8":
                          ServiceCall.userObj = {};
                          ServiceCall.userType = 0;

                          Globs.udRemove(Globs.userPayload);
                          Globs.udRemove(Globs.userLogin);

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => true);

                          break;
                        default:
                      }
                    });
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.black26,
                height: 0.5,
              ),
              itemCount: menuArr.length,
            ),
          )
        ],
      ),
    );
  }
}
