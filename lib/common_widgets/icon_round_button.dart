import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class IconRoundButton extends StatelessWidget {
  final String title;
  final String icon;
  
  final VoidCallback onPressed;
  const IconRoundButton({super.key, required this.title, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            border: Border.all(color: TColor.secondaryText, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: 25,
              height: 25,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}