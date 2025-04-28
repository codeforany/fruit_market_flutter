import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class NotificationRow extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;

  const NotificationRow({super.key, required this.obj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Image.asset(
                obj["img"].toString(),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obj["title"].toString(),
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    Text(
                      obj["subtitle"].toString(),
                      maxLines: 2,
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 10,
                      ),
                    ),

                    Spacer(),
                    Text(
                      obj["status"].toString(),
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
                Icons.more_vert,
                color: TColor.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
