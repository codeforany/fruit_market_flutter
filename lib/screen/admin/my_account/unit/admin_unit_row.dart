import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class AdminUnitRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AdminUnitRow(
      {super.key,
      required this.obj,
      required this.onPressed,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              obj["unit_name"].toString(),
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                "(${obj["unit_value"].toString()})",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 12,
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
