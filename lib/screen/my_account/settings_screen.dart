import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/screen/my_account/account_setting_screen.dart';
import 'package:fruitmarket/screen/my_account/address_list_screen.dart';
import 'package:fruitmarket/screen/my_account/change_address_screen.dart';
import 'package:fruitmarket/screen/my_account/language_setting_screen.dart';
import 'package:fruitmarket/screen/my_account/notification_setting_screen.dart';
import 'package:fruitmarket/screen/my_account/setting_row.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List settingArr = [
    {'name': 'Account', 'icon': 'assets/img/account_s.png', 'order': '1'},
    {
      'name': 'Notification',
      'icon': 'assets/img/notification_s.png',
      'order': '2'
    },
    {'name': 'Language', 'icon': 'assets/img/language_s.png', 'order': '3'},
    {
      'name': 'Address List',
      'icon': 'assets/img/change_addess_s.png',
      'order': '4'
    },
  ];

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
          "Settings",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          var obj = settingArr[index];
          return SettingRow(
              title: obj['name'].toString(),
              icon: obj['icon'].toString(),
              onPressed: () {
                switch (obj["order"].toString()) {
                  case "1":
                    context.push(const AccountSettingScreen());
                    break;
                  case "2":
                    context.push(const NotificationSettingScreen());
                    break;
                  case "3":
                    context.push(const LanguageSettingScreen());
                    break;
                  case "4":
                    context.push(const AddressListScreen());
                    break;
                  default:
                }
              });
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.black26,
          height: 0.5,
        ),
        itemCount: settingArr.length,
      ),
    );
  }
}
