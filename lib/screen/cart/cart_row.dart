import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class CartRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;
  final VoidCallback onAddQTY;
  final VoidCallback onSubQTY;
  final VoidCallback onDelete;

  const CartRow(
      {super.key,
      required this.obj,
      required this.onPressed,
      required this.onAddQTY,
      required this.onSubQTY,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {

    var qty =  double.tryParse(obj["qty"].toString()) ?? 1.0;
    var amount = double.tryParse(obj["amount"].toString()) ?? 1.0;

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: CachedNetworkImage(
                imageUrl: obj["image"].toString(),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        obj["item_name"].toString(),
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Spacer(),
                      // Expanded(
                      //   child: Text(
                      //     " \$1.00 Saved",
                      //     style: TextStyle(
                      //       color: TColor.primary,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: onDelete,
                        child: Icon(
                          Icons.delete_forever,
                          color: TColor.primaryText,
                        ),
                      )
                    ],
                  ),
                  // Text(
                  //   "\$190",
                  //   maxLines: 1,
                  //   style: TextStyle(
                  //     color: TColor.secondaryText,
                  //     fontSize: 14,
                  //     decoration: TextDecoration.lineThrough
                  //   ),
                  // ),
                  Text(
                    "\$${obj["amount"]} Per/${obj["unit_name"]}",
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        " ${obj["qty"]} x \$${obj["amount"]} = ${ (qty * amount).toStringAsFixed(2) }",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: onSubQTY,
                        icon: Icon(
                          Icons.indeterminate_check_box_outlined,
                          color: TColor.primaryText,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          obj["qty"].toString(),
                          maxLines: 1,
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onAddQTY,
                        icon: Icon(
                          Icons.add_box_outlined,
                          color: TColor.primaryText,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
