import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/screen/notification/notification_row.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List orderArr = [
    {
      'title': 'Buy 1kg Get 200gm Free',
      'subtitle': 'Buy 1 Get 1 Free for small sizes Until Feb 27,2021 .',
      'status': 'Few minutes ago',
      'img': 'assets/img/f1.png',
    },
    {
      'title': 'Onion',
      'subtitle': 'Get 20% discount offer on buying Peaches today.',
      'status': '30 minutes ago',
      'img': 'assets/img/f2.png',
    },
    {
      'title': 'Anjeer',
      'subtitle':'Get 20% discount offer on buying Broccoli today.',
      'status': '1 Hour ago',
      'img': 'assets/img/f3.png',
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
          "Notification",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "Today",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                itemBuilder: (context, index) {
                  var obj = orderArr[index];

                  return NotificationRow(obj: obj, onPressed: () {});
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                ),
                itemCount: orderArr.length,
              ),
            ],
          );
        },
        itemCount: 2,
      ),
    );
  }
}
