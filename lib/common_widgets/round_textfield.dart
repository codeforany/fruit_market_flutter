import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class RoundTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int? minLine;
  final int? maxLine;

  const RoundTextfield(
      {super.key,
      this.controller,
      required this.hintText,
      this.keyboardType,
      this.minLine,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: TColor.placeholder, width: 0.5)),
      child: TextField(
        keyboardType: keyboardType,
        minLines: minLine,
        maxLines: maxLine,
        controller: controller,
        style: TextStyle(
          color: TColor.primaryText,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: TColor.placeholder,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
