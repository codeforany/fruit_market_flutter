import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class SelectButton extends StatelessWidget {
  final String title;
  final bool isSelect;
  final VoidCallback onPressed;

  const SelectButton(
      {super.key,
      required this.title,
      this.isSelect = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: isSelect ? TColor.secondary : Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isSelect ? TColor.whiteText : TColor.secondaryText,
            fontSize: 14,
            fontWeight: isSelect ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
