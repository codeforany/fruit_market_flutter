import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

enum RoundButtonType { primary, line, secondary }

class RoundButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Alignment alignment;
  final RoundButtonType type;
  final VoidCallback onPressed;

  const RoundButton(
      {super.key,
      required this.title,
      this.type = RoundButtonType.primary,
      this.alignment = Alignment.center,
      this.width = double.maxFinite,
      this.height = 50,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            color: type == RoundButtonType.primary
                ? TColor.primary
                : type == RoundButtonType.secondary
                    ? TColor.secondary
                    : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: type == RoundButtonType.line
                ? Border.all(color: TColor.secondaryText, width: 1)
                : null),
        alignment: alignment,
        child: Text(
          title,
          style: TextStyle(
            color: type == RoundButtonType.line
                ? TColor.primaryText
                : TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
