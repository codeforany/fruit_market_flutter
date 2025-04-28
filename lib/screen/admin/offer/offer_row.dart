import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';

class OfferRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPressed;

  const OfferRow({super.key, required this.obj, required this.onPressed, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    obj["offer_name"].toString(),
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
      
                  Text(
                    obj["offer_description"].toString(),
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
      
                  Text(
                    "${ obj["start_date"].toString().displayDate(displayFormat: "dd MMM" )  } - ${obj["end_date"].toString().displayDate(displayFormat: "dd MMM yyyy")} offer start",
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 12,
                    ),
                  ),
      
      
      
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
