import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/image_picker_view.dart';
import 'package:fruitmarket/common_widgets/popup_layout.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_drop_down_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';
import 'package:fruitmarket/screen/admin/items/admin_item_nutrition_add.dart';
import 'package:fruitmarket/screen/admin/items/admin_item_nutrition_edit.dart';
import 'package:fruitmarket/screen/admin/items/admin_item_price_screen.dart';

class AdminItemAddScreen extends StatefulWidget {
  final bool isEdit;
  final Map? obj;

  const AdminItemAddScreen({super.key, this.isEdit = false, this.obj});

  @override
  State<AdminItemAddScreen> createState() => _AdminItemAddScreenState();
}

class _AdminItemAddScreenState extends State<AdminItemAddScreen> {
  List mainCategoryArr = [];
  List categoryArr = [];
  List selectCategory = [];
  Map? selectMainCat;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  File? selectImage;

  List nutritionArr = [];
  List priceArr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apiCallingMainCatList();
    if (widget.isEdit) {
      txtName.text = widget.obj?["item_name"]?.toString() ?? "";
      txtDescription.text = widget.obj?["description"]?.toString() ?? "";

      apiCallingNutritionList();
      apiCallingPriceList();
    }
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
          widget.isEdit ? "Edit Item" : "Add Item",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Item Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                controller: txtName,
                hintText: "",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Item Description",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                controller: txtDescription,
                hintText: "",
                maxLine: 10,
                minLine: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Main Category",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundDropDownButton(
                  hintText: "Select",
                  displayKey: "main_cat_name",
                  itemsArr: mainCategoryArr,
                  selectVal: selectMainCat,
                  didChanged: (newVal) {
                    selectMainCat = newVal;
                    setState(() {});
                    apiCallingCategoryList(
                        {"main_cat_id": newVal["main_cat_id"].toString()});
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Category's",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    childAspectRatio: (context.width / 2) / 35,
                    mainAxisSpacing: 4),
                itemBuilder: (context, index) {
                  var obj = categoryArr[index];

                  var isSelected = selectCategory.contains(obj);
                  return InkWell(
                    onTap: () {
                      if (selectCategory.contains(obj)) {
                        selectCategory.remove(obj);
                      } else {
                        selectCategory.add(obj);
                      }
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: TColor.primary,
                            size: 25,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              obj["cat_name"].toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                color: TColor.primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: categoryArr.length,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Item Image",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PopupLayout(
                      child: ImagePickerView(
                        didSelect: (imagePath) {
                          selectImage = File(imagePath);

                          if (widget.isEdit) {
                            apiCallUpdateImage({
                              "item_id":
                                  widget.obj?["item_id"].toString() ?? "",
                            }, {
                              'image': selectImage!
                            });
                          }

                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: context.width - 40,
                  height: context.width - 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: selectImage != null
                        ? Image.file(
                            selectImage!,
                            width: context.width - 56,
                            height: context.width - 56,
                            fit: BoxFit.cover,
                          )
                        : widget.isEdit
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.obj!["image"].toString(),
                                  width: context.width - 56,
                                  height: context.width - 56,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.image,
                                size: 150,
                                color: TColor.secondaryText,
                              ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                  title: widget.isEdit ? "UPDATE" : "ADD",
                  onPressed: () {
                    clkSubmit();
                  }),
              SizedBox(
                height: 20,
              ),
              if (widget.isEdit)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nutrition",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: TColor.primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            context.push(AdminItemNutritionAdd(
                              obj: widget.obj!,
                            ));
                          },
                          icon: Icon(
                            Icons.add,
                            color: TColor.primary,
                          ))
                    ],
                  ),
                ),
              if (widget.isEdit)
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var obj = nutritionArr[index];
                    return SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(child: Text(obj["name"])),
                          IconButton(
                            onPressed: () async {
                              await context
                                  .push(AdminItemNutritionEdit(obj: obj));
                              apiCallingNutritionList();
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              mdShowAlertTowButton(
                                  Globs.appName, "Are you sure want to delete?",
                                  () {
                                apiCallNutritionDelete({
                                  'nutrition_id':
                                      obj["nutrition_id"].toString(),
                                });
                              }, () {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: nutritionArr.length,
                ),
              if (widget.isEdit)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price List",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: TColor.primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await context.push(AdminItemPriceScreen(
                              obj: widget.obj!,
                            ));

                            apiCallingPriceList();
                          },
                          icon: Icon(
                            Icons.add,
                            color: TColor.primary,
                          ))
                    ],
                  ),
                ),
              if (widget.isEdit)
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var obj = priceArr[index];
                    return SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(child: Text(obj["unit_name"])),
                          Text(
                            "\$${obj["amount"].toString()}",
                            style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              mdShowAlertTowButton(
                                  Globs.appName, "Are you sure want to delete?",
                                  () {
                                apiCallPriceDelete({
                                  'price_id': obj["price_id"].toString(),
                                  'item_id': obj["item_id"].toString(),
                                });
                              }, () {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: priceArr.length,
                )
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Action
  void clkSubmit() {
    if (txtName.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter item name", () {});
      return;
    }

    if (txtDescription.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter item description", () {});
      return;
    }

    if (selectMainCat == null) {
      mdShowAlert(Globs.appName, "Please select main category", () {});
      return;
    }

    if (selectCategory.isEmpty) {
      mdShowAlert(Globs.appName, "Please select sub category", () {});
      return;
    }

    if (!widget.isEdit && selectImage == null) {
      mdShowAlert(Globs.appName, "Please select item image", () {});
      return;
    }

    endEditing();

    if (widget.isEdit) {
      apiCallUpdate({
        'item_id': widget.obj?["item_id"].toString() ?? "",
        'main_cat_id': selectMainCat!["main_cat_id"].toString(),
        'cat_id':
            selectCategory.map((cObj) => cObj["cat_id"]).toList().join(','),
        'item_name': txtName.text,
        'description': txtDescription.text
      });
    } else {
      apiCallAdd({
        'main_cat_id': selectMainCat!["main_cat_id"].toString(),
        'cat_id':
            selectCategory.map((cObj) => cObj["cat_id"]).toList().join(','),
        'item_name': txtName.text,
        'description': txtDescription.text
      }, {
        "image": selectImage!
      });
    }
  }

  //TODO: ApiCalling
  void apiCallingMainCatList() {
    Globs.showHUD();

    ServiceCall.post(
      {},
      SVKey.adminMainCategoryList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mainCategoryArr = responseObj[KKey.payload] as List? ?? [];

          if (widget.isEdit) {
            selectMainCat = mainCategoryArr.firstWhere(
              (obj) {
                return obj["main_cat_id"] == widget.obj!["main_cat_id"];
              },
              orElse: () => null,
            );

            if (selectMainCat != null) {
              apiCallingCategoryList(
                {"main_cat_id": selectMainCat!["main_cat_id"].toString()},
                isPreSelect: true,
              );
            }
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
        mdShowAlert(Globs.appName, error.toString(), () {});
      },
    );
  }

  void apiCallingCategoryList(Map<String, dynamic> parameter,
      {bool isPreSelect = false}) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminCategoryList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          selectCategory = [];
          categoryArr = responseObj[KKey.payload] as List? ?? [];

          if (widget.isEdit && isPreSelect) {
            var selectArr = widget.obj?["cat_id"].toString().split(",") ?? [];
            for (var obj in categoryArr) {
              if (selectArr.contains(obj["cat_id"].toString())) {
                selectCategory.add(obj);
              }
            }
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
        mdShowAlert(Globs.appName, error.toString(), () {});
      },
    );
  }

  void apiCallAdd(Map<String, String> parameter, Map<String, File> imageObj) {
    Globs.showHUD();

    ServiceCall.multipart(
      parameter,
      SVKey.adminItemAdd,
      imgObj: imageObj,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(Globs.appName, responseObj[KKey.message].toString(), () {
            context.pop();
          });
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

  void apiCallUpdateImage(
      Map<String, String> parameter, Map<String, File> imageObj) {
    Globs.showHUD();

    ServiceCall.multipart(
      parameter,
      SVKey.adminItemImageUpdate,
      imgObj: imageObj,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
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

  void apiCallUpdate(Map<String, String> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminItemUpdate,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
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

  void apiCallingNutritionList() {
    Globs.showHUD();

    ServiceCall.post(
      {"item_id": widget.obj?["item_id"].toString()},
      SVKey.adminItemNutritionList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          nutritionArr = responseObj[KKey.payload] as List? ?? [];
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

  void apiCallNutritionDelete(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminItemNutritionDelete,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
          apiCallingNutritionList();
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

  void apiCallingPriceList() {
    Globs.showHUD();

    ServiceCall.post(
      {"item_id": widget.obj?["item_id"].toString()},
      SVKey.adminItemPriceList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          priceArr = responseObj[KKey.payload] as List? ?? [];
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

  void apiCallPriceDelete(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminItemPriceDelete,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(
              Globs.appName, responseObj[KKey.message].toString(), () {});
          apiCallingPriceList();
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
