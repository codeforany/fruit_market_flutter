import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {

  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.whiteText,
          ),
        ),
        centerTitle: false,
        title: Text(
          "Add Your Card",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/card_demo.png",
                    width: context.width * 0.5,
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Cardholder Name",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 12,
                ),
              ),
              RoundTextfield(hintText: "Enter Card Name"),
              SizedBox(
                height: 8,
              ),
              Text(
                "Card Number",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RoundTextfield(
                      hintText: "0000",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RoundTextfield(
                      hintText: "0000",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RoundTextfield(
                      hintText: "0000",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RoundTextfield(
                      hintText: "0000",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Valid Thru",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RoundTextfield(
                      hintText: "MMMM",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 120,
                    child: RoundTextfield(
                      hintText: "YYYY",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "CVC/CVV",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: RoundTextfield(
                      hintText: "CVC/CVV",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "3 or 4 digit code",
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSaved = !isSaved;
                    });
                  },
                  icon: Icon(
                   isSaved ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                    color: TColor.primary,
                    size: 35,
                  )),
              SizedBox(
                height: 25,
              ),
              RoundButton(title: "ADD CARD NUMBER", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
