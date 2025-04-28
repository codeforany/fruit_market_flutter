import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class AddressRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AddressRow(
      {super.key,
      required this.obj,
      required this.onPressed,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    obj["name"].toString(),
                    maxLines: 1,
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    obj["address"].toString(),
                    maxLines: 1,
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        obj["city"].toString(),
                        maxLines: 1,
                        style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 14,
                        ),
                      ),
                      
                      Text(
                        ", ${obj["zip_code"].toString()}" ,
                        maxLines: 1,
                        style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 14,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit,
                    color: TColor.primary,
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
          ],
        ),
      ),
    );
  }
}
