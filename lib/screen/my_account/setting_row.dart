import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class SettingRow extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPressed;

  const SettingRow(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        height: 60,
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 25,
              height: 25,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
