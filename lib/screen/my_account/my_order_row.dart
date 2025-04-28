import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/globs.dart';

class MyOrderRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;

  const MyOrderRow({super.key, required this.obj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obj["item_name"].toString(),
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: RatingBar.builder(
                        initialRating:
                            double.tryParse(obj["rating"].toString()) ?? 0.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Text(
                      "Rate this Product",
                      maxLines: 1,
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      statusText(),
                      maxLines: 1,
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: TColor.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String statusText() {
    //0 = New Order, 1 = Order Accept, 2= Wait for Delivery, 3 = Out for Delivery, 4 = Done, 5 = Cancel, 7 = Order Reject.

    switch (obj[KKey.status].toString()) {
      case "0":
        return "Order Placed";
      case "1":
        return "Order Processing";
      case "2":
        return "Order Shipped";
      case "3":
        return "Out of Delivery";
      case "4":
        return "Order Delivered";
      case "5":
        return "Order Cancel";
      case "7":
        return "Order Reject";
      default:
        return "";
    }
  }
}
