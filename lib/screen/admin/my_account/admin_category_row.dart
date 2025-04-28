import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class AdminCategoryRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(bool) onActive;

  const AdminCategoryRow(
      {super.key,
      required this.obj,
      required this.onPressed,
      required this.onEdit,
      required this.onDelete,
      required this.onActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  Text(
                    obj["cat_name"].toString(),
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    obj["subtitle"].toString(),
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
            ),
            Switch(
                value: (obj["status"] as int? ?? 0) == 1, onChanged: onActive),
          ],
        ),
      ),
    );
  }
}
