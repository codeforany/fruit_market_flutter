import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';

class FavoriteRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;

  const FavoriteRow({super.key, required this.obj, required this.onPressed});

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
              child: Image.asset(
                obj["img"].toString(),
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
                      Expanded(
                        child: Text(
                          obj["title"].toString(),
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "\$${obj["price"]} Per/${obj["unit"]}",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Pick up from organic farms",
                    maxLines: 1,
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 10,
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.indeterminate_check_box_outlined,
                          color: TColor.primaryText,
                          size: 35,
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 8),
                         child: Text(
                            "1",
                            maxLines: 1,
                            style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                       ),
                      
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_box_outlined,
                          color: TColor.primaryText,
                          size: 35,
                        ),
                      ),

                      Spacer(),

                      RoundButton(title: "Add",
                      type: RoundButtonType.secondary,
                      width: 90,
                      height: 35,
                       onPressed: (){

                      })
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
