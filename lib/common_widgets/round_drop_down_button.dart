import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundDropDownButton extends StatelessWidget {
  final String hintText;
  final Map? selectVal;
  final String displayKey;
  final List itemsArr;
  final Function(dynamic) didChanged;

  const RoundDropDownButton(
      {super.key,
      required this.hintText,
      this.selectVal,
      required this.displayKey,
      required this.itemsArr,
      required this.didChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: TColor.placeholder, width: 0.5)),
      child: DropdownButtonHideUnderline(
        
        child: DropdownButton(
            isExpanded: true,
              hint: Text(
                hintText,
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 16,
                ),
              ),
              value:  selectVal,
              items: itemsArr.map((itemObj) {
                return DropdownMenuItem(
                  value: itemObj,
                  child: Text(itemObj[displayKey] as String? ?? ""),
                );
              }).toList(),
              onChanged: didChanged),
      ),
    );
  }
}
