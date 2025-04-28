import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/screen/favorites/favorite_row.dart';

class FavoritesTabScreen extends StatefulWidget {
  const FavoritesTabScreen({super.key});

  @override
  State<FavoritesTabScreen> createState() => _FavoritesTabScreenState();
}

class _FavoritesTabScreenState extends State<FavoritesTabScreen> {
  List orderArr = [
    {
      'title': 'Broccoli',
      'rating': '5',
      'status': 'Delivered on 05 Jan 2025.',
      'img': 'assets/img/f1.png',
      'price':'160',
      'unit':'kg'
    },
    {
      'title': 'Onion',
      'rating': '5',
      'status': 'Delivered on 05 Jan 2025.',
      'img': 'assets/img/f2.png',
      'price': '160',
      'unit': 'kg'
    },
    {
      'title': 'Anjeer',
      'rating': '5',
      'status': 'Delivered on 05 Jan 2025.',
      'img': 'assets/img/f3.png',
      'price': '160',
      'unit': 'kg'
    },
    {
      'title': 'Onion',
      'rating': '5',
      'status': 'Delivered on 05 Jan 2025.',
      'img': 'assets/img/f2.png',
      'price': '160',
      'unit': 'kg'
    },
    {
      'title': 'Anjeer',
      'rating': '5',
      'status': 'Delivered on 05 Jan 2025.',
      'img': 'assets/img/f3.png',
      'price': '160',
      'unit': 'kg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Container(),
        leadingWidth: 15,
        title: Text(
          "Favorites",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        itemBuilder: (context, index) {
          var obj = orderArr[index];

          return FavoriteRow(obj: obj, onPressed: (){
            
          });
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            color: Colors.black26,
            height: 1,
          ),
        ),
        itemCount: orderArr.length,
      ),
    );
  }
}
