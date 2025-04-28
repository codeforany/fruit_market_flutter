import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/admin/items/admin_item_add_screen.dart';
import 'package:fruitmarket/screen/admin/items/admin_item_row.dart';
import 'package:fruitmarket/screen/admin/my_account/admin_category_list_screen.dart';
import 'package:fruitmarket/screen/admin/my_account/admin_main_category_add.dart';
import 'package:fruitmarket/screen/admin/my_account/main_category_row.dart';

class AdminItemListScreen extends StatefulWidget {
  final Map obj;
  const AdminItemListScreen({super.key, required this.obj});

  @override
  State<AdminItemListScreen> createState() => _AdminItemListScreenState();
}

class _AdminItemListScreenState extends State<AdminItemListScreen> {
  List itemArr = [];

  // {
  //     'title': 'Vegetables',
  //   },
  //   {
  //     'title': 'Fruits',
  //   },
  //   {
  //     'title': 'Dry Fruits',
  //   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallingList();
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
          "${widget.obj["main_cat_name"].toString()} Items",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(AdminItemAddScreen());
              // apiCallingList();
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: itemArr.isEmpty
          ? Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  color: TColor.placeholder,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              itemBuilder: (context, index) {
                var obj = itemArr[index];

                return AdminItemRow(
                  obj: obj,
                  onPressed: () {
                    // context.push(AdminItemListScreen());
                  },
                  onEdit: () async {
                    await context.push(AdminItemAddScreen(
                      isEdit: true,
                      obj: obj,
                    ));
                    apiCallingList();
                  },
                  onDelete: () {
                    mdShowAlertTowButton(
                        Globs.appName, "Are you sure want to delete?", () {
                      apiCallDelete({
                        'item_id': obj["item_id"].toString(),
                      });
                    }, () {});
                  },
                  onNutrition: () {
                    
                  },
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  color: Colors.black26,
                  height: 1,
                ),
              ),
              itemCount: itemArr.length,
            ),
    );
  }

  //TODO: ApiCalling
  void apiCallingList() {
    Globs.showHUD();

    ServiceCall.post(
      {"main_cat_id": widget.obj["main_cat_id"].toString()},
      SVKey.adminItemList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          itemArr = responseObj[KKey.payload] as List? ?? [];
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
      SVKey.adminItemDelete,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
          apiCallingList();
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

  // void apiCallActiveInactive(Map<String, dynamic> parameter) {
  //   Globs.showHUD();

  //   ServiceCall.post(
  //     parameter,
  //     SVKey.adminMainCategoryActiveInactive,
  //     isTokenApi: true,
  //     withSuccess: (responseObj) async {
  //       Globs.hideHUD();
  //       if (responseObj[KKey.status] == "1") {
  //         apiCallingList();
  //       } else {
  //         mdShowAlert(
  //             Globs.appName, responseObj[KKey.message].toString(), () {});
  //       }
  //     },
  //     failure: (error) async {
  //       Globs.hideHUD();
  //       mdShowAlert(Globs.appName, error.toString(), () {});
  //     },
  //   );
  // }
}
