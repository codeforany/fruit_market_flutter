import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/screen/my_account/setting_row.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  List settingArr = [
    {'name': 'Security', 'icon': 'assets/img/secure_s.png', 'order': '1'},
    {
      'name': 'Deactivate Account',
      'icon': 'assets/img/delete_account_s.png',
      'order': '2'
    },
    {'name': 'Delete Account', 'icon': 'assets/img/delete_user_s.png', 'order': '3'},
   
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
          "Account Setting",
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
                    break;
                  case "2":
                    break;
                  case "3":
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
