import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/admin/offer/offer_add_screen.dart';
import 'package:fruitmarket/screen/admin/offer/offer_row.dart';

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({super.key});

  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  List offerArr = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallOfferList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.whiteText,
          ),
        ),
        title: Text(
          "Offers",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(OfferAddScreen());
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Color(0xfffdfdfd),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: (context, index) {
          var obj = offerArr[index];
          return OfferRow(
            obj: obj,
            onPressed: () {
              context.push(OfferAddScreen());
            },
            onEdit: () async {
              await context.push(OfferAddScreen(
                isEdit: true,
                editObj: obj,
              ));
              apiCallOfferList();
            },
            onDelete: () {
              mdShowAlertTowButton(
                  Globs.appName, "Are you sure want to delete?", () {
                apiCallDelete({
                  'offer_id': obj["offer_id"].toString(),
                });
              }, () {});
            },
          );
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Divider(
            height: 1,
          ),
        ),
        itemCount: offerArr.length,
      ),
    );
  }

  //TODO: ApiCalling
  void apiCallOfferList() {
    // Globs.showHUD();

    ServiceCall.post(
      {},
      SVKey.adminOfferList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          offerArr = responseObj[KKey.payload] as List? ?? [];

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

  void apiCallDelete(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminOfferDelete,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
          apiCallOfferList();
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
}
