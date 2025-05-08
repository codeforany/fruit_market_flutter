import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/review_row.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';

class DetailScreen extends StatefulWidget {
  final Map obj;
  const DetailScreen({super.key, required this.obj});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map? detailObj;
  List nutritionArr = [];
  List reviewArr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallingDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.whiteText,
          ),
        ),
        centerTitle: false,
        title: Text(
          "Details",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${widget.obj["amount"]} per/ ${widget.obj["unit_name"]}",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              RoundButton(
                  title: "Buy Now",
                  width: 140,
                  height: 44,
                  onPressed: () {
                    apiCallingCartToAdd();
                  })
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: widget.obj["image"].toString(),
                  width: double.maxFinite,
                  height: context.width * 0.45,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.obj["item_name"].toString(),
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.obj["description"].toString(),
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Nutrition",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var nObj = nutritionArr[index];

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: TColor.secondaryText,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Expanded(
                        child: Text(
                          nObj["name"].toString(),
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: nutritionArr.length,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "User Reviews",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var obj = reviewArr[index];

                  return ReviewRow(obj: obj);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: reviewArr.length,
              )
            ],
          ),
        ),
      ),
    );
  }

  //TODO: ServiceCall

  void apiCallingDetail() {
    Globs.showHUD();
    ServiceCall.post(
      {
        "item_id": widget.obj["item_id"].toString(),
        "price_id": widget.obj["price_id"].toString()
      },
      SVKey.itemDetail,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();

        if (responseObj[KKey.status].toString() == "1") {
          detailObj = responseObj[KKey.payload] as Map? ?? {};
          nutritionArr = detailObj?["nutrition_list"] as List ?? [];
          reviewArr = detailObj?["review_list"] as List ?? [];
          if (mounted) {
            setState(() {});
          }
        } else {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
        }
      },
      failure: (error) async {
        Globs.hideHUD();
        mdShowAlert(Globs.appName, error.toString(), () {});
      },
    );
  }

  void apiCallingCartToAdd() {
    Globs.showHUD();
    ServiceCall.post({
      'item_id': widget.obj["item_id"].toString(),
      'price_id': widget.obj["price_id"].toString(),
      'qty': '1',
    }, SVKey.addToCart, isTokenApi: true, withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status].toString() == "1") {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      } else {
        mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }
}
