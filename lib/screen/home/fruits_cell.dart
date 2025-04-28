import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';

class FruitsCell extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;

  const FruitsCell({super.key, required this.obj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: context.width * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [

          

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: 
                  
                  CachedNetworkImage(
                    imageUrl: obj["image"].toString(),
                    width: context.width * 0.35,
                    height: context.width * 0.42,
                    fit: BoxFit.cover,
                  ),

                   
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            IgnorePointer(
              ignoring: true,
              child: RatingBar.builder(
                initialRating: double.tryParse(obj["rate"].toString()) ?? 0.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 16,
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
              obj["item_name"].toString(),
              maxLines: 1,
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "\$${obj["amount"]} per/ ${obj["unit_name"]}",
              maxLines: 1,
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}