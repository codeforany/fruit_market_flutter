import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  List settingArr = [
    {
      'title': 'My Account',
      'subtitle': 'You will receive daily updates',
      'value': true,
      'order': '1'
    },
    {
      'title': 'Pramotional Notifications',
      'subtitle': 'You will receive daily updates',
      'value': false,
      'order': '1'
    }
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
          "Notification Setting",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var obj = settingArr[index];
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 60,
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/notification_s.png",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          obj["title"],
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          obj["subtitle"],
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                      value: obj["value"],
                      activeColor: TColor.primary,
                      onChanged: (newVal) {
                        setState(() {
                          settingArr[index]["value"] = newVal;
                        });
                      })
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                color: Colors.black26,
                height: 1,
              ),
          itemCount: settingArr.length),
    );
  }
}
