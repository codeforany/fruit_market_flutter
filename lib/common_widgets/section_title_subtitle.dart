import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';

class SectionTitleSubtitle extends StatelessWidget {
  final String title;
  final String offerTitle;
  final String subtitle;

  const SectionTitleSubtitle({super.key, required this.title, required this.offerTitle, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                offerTitle,
                style: TextStyle(
                  color: TColor.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}