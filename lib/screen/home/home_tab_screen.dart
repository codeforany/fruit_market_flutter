import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/section_title_subtitle.dart';
import 'package:fruitmarket/common_widgets/select_button.dart';
import 'package:fruitmarket/screen/home/detail_screen.dart';
import 'package:fruitmarket/screen/home/fruits_cell.dart';
import 'package:fruitmarket/screen/notification/notification_screen.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  int selectTab = 0;
  List categoryArr = [];

  List subCategoryArr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallingMainCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Container(),
        leadingWidth: 15,
        title: Text(
          "Fruit Market",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.push(const NotificationScreen());
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: TColor.primary,
                  width: double.maxFinite,
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 4),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: TColor.placeholder,
                      ),
                      hintStyle: TextStyle(
                        color: TColor.placeholder,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categoryArr.map((catObj) {
                    var index = categoryArr.indexOf(catObj);
                    var obj = categoryArr[index];
                    return Expanded(
                      child: SelectButton(
                          title: obj["main_cat_name"].toString(),
                          isSelect: selectTab == index,
                          onPressed: () {
                            setState(() {
                              selectTab = index;
                            });

                            apiCallingHome(
                                {"main_cat_id": obj["main_cat_id"].toString()});
                          }),
                    );
                  }).toList()),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var obj = subCategoryArr[index];
                var itemArr = obj["items"] as List? ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitleSubtitle(
                        title: obj["cat_name"].toString(),
                        offerTitle: "",
                        subtitle: obj["subtitle"].toString()),
                    SizedBox(
                      height: context.width * 0.42 + 80,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var obj = itemArr[index];
                          return FruitsCell(
                              obj: obj,
                              onPressed: () {
                                context.push(DetailScreen(
                                  obj: obj,
                                ));
                              });
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 20,
                        ),
                        itemCount: itemArr.length,
                      ),
                    ),
                  ],
                );
              },
              itemCount: subCategoryArr.length,
            )
          ],
        ),
      ),
    );
  }

  //TODO: ServiceCall

  void apiCallingMainCategoryList() {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.mainCategoryList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();

        if (responseObj[KKey.status].toString() == "1") {
          categoryArr = responseObj[KKey.payload] as List? ?? [];

          if (categoryArr.length > 0) {
            apiCallingHome(
                {"main_cat_id": categoryArr.first["main_cat_id"].toString()});
          }
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
      },
    );
  }

  void apiCallingHome(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(
      parameter,
      SVKey.home,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();

        if (responseObj[KKey.status].toString() == "1") {
          subCategoryArr = responseObj[KKey.payload] as List? ?? [];
          if (mounted) {
            setState(() {});
          }
        } else {
          subCategoryArr = [];
          if (mounted) {
            setState(() {});
          }
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
        }
      },
      failure: (error) async {
        Globs.hideHUD();
      },
    );
  }
}
