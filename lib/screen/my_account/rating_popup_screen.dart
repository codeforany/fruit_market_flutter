import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';

class RatingPopupScreen extends StatefulWidget {
  final Function(String, double) didSubmit;
  const RatingPopupScreen({super.key, required this.didSubmit});

  @override
  State<RatingPopupScreen> createState() => _RatingPopupScreenState();
}

class _RatingPopupScreenState extends State<RatingPopupScreen> {
  TextEditingController txtMessage = TextEditingController();
  double rating = 5.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -2), blurRadius: 4)
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: context.width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rating & Review",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  color: TColor.primary,
                  size: 25,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 50,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.orange,
            ),
            onRatingUpdate: (rating) {
              this.rating = rating;
              print(rating);
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Review Message",
            style: TextStyle(
              fontSize: 16,
              color: TColor.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          RoundTextfield(
            hintText: "",
            controller: txtMessage,
            minLine: 6,
            maxLine: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: RoundButton(title: "Submit", onPressed: () {
               context.pop();
               widget.didSubmit(txtMessage.text, rating);
            }),
          )
        ],
      ),
    );
  }
}
