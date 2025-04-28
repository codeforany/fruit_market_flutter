import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';

class PickupLanguageScreen extends StatefulWidget {
  final Function(Map) onChanged;

  const PickupLanguageScreen({super.key, required this.onChanged});

  @override
  State<PickupLanguageScreen> createState() => _PickupLanguageScreenState();
}

class _PickupLanguageScreenState extends State<PickupLanguageScreen> {
  List settingArr = [
    {
      'title': 'English',
      'value': 'en',
    },
    {
      'title': 'Hindi',
      'value': 'hi',
    },
    {
      'title': 'Gujarati',
      'value': 'gu',
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
          "Pickup Language",
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
            return InkWell(
              onTap: (){

                context.pop();
                widget.onChanged(obj);

              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 60,
                alignment: Alignment.centerLeft,
                child:  Text(
                  obj["title"],
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
