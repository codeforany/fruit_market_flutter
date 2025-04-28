import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class ReasonTextPopup extends StatefulWidget {
  final Function(String) didSubmit;
  const ReasonTextPopup({super.key, required this.didSubmit});

  @override
  State<ReasonTextPopup> createState() => _ReasonTextPopupState();
}

class _ReasonTextPopupState extends State<ReasonTextPopup> {
  TextEditingController txtReason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.9,
      height: context.width * 0.8,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black54, blurRadius: 4, spreadRadius: 4)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Reason",
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: context.width * 0.04,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Enter Reason",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          RoundTextfield(
            controller: txtReason,
            hintText: "",
            minLine: 6,
            maxLine: 6,
          ),
          SizedBox(
            height: context.width * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  widget.didSubmit(txtReason.text);
                  dismiss();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: TColor.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              TextButton(
                onPressed: () {
                  dismiss();
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: TColor.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //TODO: ACTION

  void dismiss() {
    context.pop();
  }
}
