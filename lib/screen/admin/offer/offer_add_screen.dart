import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_drop_down_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class OfferAddScreen extends StatefulWidget {
  final bool isEdit;
  final Map? editObj;
  const OfferAddScreen({super.key, this.isEdit = false, this.editObj});

  @override
  State<OfferAddScreen> createState() => _OfferAddScreenState();
}

class _OfferAddScreenState extends State<OfferAddScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  TextEditingController txtPer = TextEditingController();
  TextEditingController txtBuyQty = TextEditingController();
  TextEditingController txtGetQty = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  bool isTypeCategory = true;
  bool isPer = true;

  Map? selectCategory;
  Map? selectBuyUnit;
  Map? selectGetUnit;
  Map? selectItem;

  List categoryArr = [];
  List itemArr = [];
  List unitArr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCallCategoryList({});
    apiCallUnitList({});
    apiCalItemList();

    if (widget.isEdit) {
      txtName.text = widget.editObj?["offer_name"].toString() ?? "";
      txtDescription.text =
          widget.editObj?["offer_description"].toString() ?? "";

      isTypeCategory = (widget.editObj?["type"].toString() ?? "1") == "1";
      isPer = (widget.editObj?["offer_type"].toString() ?? "1") == "1";

      txtPer.text = widget.editObj?["offer_value"].toString() ?? "";
      txtBuyQty.text = widget.editObj?["buy_qty"].toString() ?? "";
      txtGetQty.text = widget.editObj?["get_qty"].toString() ?? "";

      startDate =
          widget.editObj?["start_date"].toString().date() ?? DateTime.now();
      endDate = widget.editObj?["end_date"].toString().date() ?? DateTime.now();
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
          "Offer Create",
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
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Offer Name",
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
                  "Offer Description",
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
                minLine: 7,
                maxLine: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Type Wise",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isTypeCategory = true;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isTypeCategory
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: TColor.primary,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Category",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: TColor.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isTypeCategory = false;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isTypeCategory
                                ? Icons.radio_button_unchecked
                                : Icons.radio_button_checked,
                            color: TColor.primary,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Item",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: TColor.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (isTypeCategory)
                RoundDropDownButton(
                    hintText: "Select Category",
                    displayKey: "main_cat_name",
                    itemsArr: categoryArr,
                    selectVal: selectCategory,
                    didChanged: (newVal) {
                      setState(() {
                        selectCategory = newVal;
                      });
                    }),
              if (!isTypeCategory)
                RoundDropDownButton(
                    hintText: "Select Item",
                    displayKey: "item_name",
                    itemsArr: itemArr,
                    selectVal: selectItem,
                    didChanged: (newVal) {
                      setState(() {
                        selectItem = newVal;
                      });
                    }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Offer Type",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isPer = true;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isPer
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: TColor.primary,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "(%)Percentage",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: TColor.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isPer = false;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isPer
                                ? Icons.radio_button_unchecked
                                : Icons.radio_button_checked,
                            color: TColor.primary,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "BuyOnGet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: TColor.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (isPer)
                RoundTextfield(
                  controller: txtPer,
                  hintText: "Enter Offer percentage(%)",
                  keyboardType: TextInputType.number,
                ),
              if (!isPer)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "How Many Buy Need Items?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: TColor.primaryText,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RoundTextfield(
                            controller: txtBuyQty,
                            hintText: "Enter Qty",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: RoundDropDownButton(
                              hintText: "Select Unit",
                              displayKey: "unit_name",
                              itemsArr: unitArr,
                              selectVal: selectBuyUnit,
                              didChanged: (newVal) {
                                setState(() {
                                  selectBuyUnit = newVal;
                                });
                              }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "How Many Get Items On Offer?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: TColor.primaryText,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RoundTextfield(
                            controller: txtGetQty,
                            hintText: "Enter Qty",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: RoundDropDownButton(
                              hintText: "Select Unit",
                              displayKey: "unit_name",
                              selectVal: selectGetUnit,
                              itemsArr: unitArr,
                              didChanged: (newVal) {
                                setState(() {
                                  selectGetUnit = newVal;
                                });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Offer Start Time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                    setState(() {
                      startDate = date;
                    });
                  }, onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      startDate = date;
                    });
                  }, minTime: DateTime.now(), currentTime: DateTime.now());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 44,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: TColor.placeholder, width: 0.5)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          startDate?.stringFormat() ?? "Select Date Time",
                          style: TextStyle(
                            fontSize: 14,
                            color: startDate == null
                                ? TColor.placeholder
                                : TColor.primaryText,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.date_range,
                        color: TColor.primary,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Offer End Time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());

                    setState(() {
                      endDate = date;
                    });
                  }, onConfirm: (date) {
                    setState(() {
                      endDate = date;
                    });
                    print('confirm $date');
                  }, minTime: DateTime.now(), currentTime: DateTime.now());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 44,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: TColor.placeholder, width: 0.5)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          endDate?.stringFormat() ?? "Select Date Time",
                          style: TextStyle(
                            fontSize: 14,
                            color: endDate == null
                                ? TColor.placeholder
                                : TColor.primaryText,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.date_range,
                        color: TColor.primary,
                      )
                    ],
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
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Action
  void clkSubmit() {
    if (txtName.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter offer name", () {});
      return;
    }

    if (txtDescription.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter offer description", () {});
      return;
    }

    if (isTypeCategory && selectCategory == null) {
      mdShowAlert(Globs.appName, "Please select category", () {});
      return;
    }

    if (!isTypeCategory && selectItem == null) {
      mdShowAlert(Globs.appName, "Please select item", () {});
      return;
    }

    if (isPer && txtPer.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter offer percentage", () {});
      return;
    }

    if (!isPer) {
      if (txtBuyQty.text.isEmpty) {
        mdShowAlert(Globs.appName, "Please enter minimum buy qty", () {});
        return;
      }

      if (selectBuyUnit == null) {
        mdShowAlert(Globs.appName, "Please select buy unit", () {});
        return;
      }

      if (txtGetQty.text.isEmpty) {
        mdShowAlert(Globs.appName, "Please enter offer qty", () {});
        return;
      }

      if (selectGetUnit == null) {
        mdShowAlert(Globs.appName, "Please select get unit", () {});
        return;
      }
    }

    if (startDate == null) {
      mdShowAlert(Globs.appName, "Please select offer start date time", () {});
      return;
    }

    if (endDate == null) {
      mdShowAlert(Globs.appName, "Please select offer end date time", () {});
      return;
    }

    endEditing();

    var sObj = {
      'offer_name': txtName.text,
      "offer_description": txtDescription.text,
      "type": isTypeCategory ? "1" : "2",
      "offer_type": isPer ? "1" : "2",
      "buy_unit_id": !isPer ? selectBuyUnit!["unit_id"].toString() : "0",
      "buy_qty": !isPer ? txtBuyQty.text.toString() : "",
      "get_qty": !isPer ? txtGetQty.text.toString() : "",
      "get_unit_id": !isPer ? selectGetUnit!["unit_id"].toString() : "0",
      "cat_id":
          isTypeCategory ? selectCategory!["main_cat_id"].toString() : "0",
      "item_id": !isTypeCategory ? selectItem!["item_id"].toString() : "0",
      "offer_value": isPer ? txtPer.text : "0",
      "start_date": startDate?.stringFormat(format: 'yyyy-MM-dd HH:mm') ?? "",
      "end_date": endDate?.stringFormat(format: 'yyyy-MM-dd HH:mm') ?? "",
    };

    if (widget.isEdit) {
      sObj["offer_id"] = widget.editObj?["offer_id"].toString() ?? "";
    }
    apiCallCreateOffer(sObj);
  }

  //TODO: ApiCalling
  void apiCallCategoryList(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminMainCategoryList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          categoryArr = responseObj[KKey.payload] as List? ?? [];

          if (widget.isEdit) {
            selectCategory = categoryArr.firstWhere(
              (obj) {
                return obj["main_cat_id"].toString() == (widget.editObj?["cat_id"].toString() ?? "");
              },
              orElse: () => null,
            );
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

  void apiCalItemList() {
    Globs.showHUD();

    ServiceCall.post(
      {},
      SVKey.adminAllItemList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          itemArr = responseObj[KKey.payload] as List? ?? [];

          if (widget.isEdit) {
            selectCategory = categoryArr.firstWhere(
              (obj) {
                return obj["item_id"] == widget.editObj?["item_id"];
              },
              orElse: () => null,
            );
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

  void apiCallUnitList(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.adminUnitList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          unitArr = responseObj[KKey.payload] as List? ?? [];

          if (widget.isEdit) {
            selectBuyUnit = categoryArr.firstWhere(
              (obj) {
                return obj["unit_id"] == widget.editObj?["buy_unit_id"];
              },
              orElse: () => null,
            );

            selectGetUnit = categoryArr.firstWhere(
              (obj) {
                return obj["unit_id"] == widget.editObj?["get_unit_id"];
              },
              orElse: () => null,
            );
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

  void apiCallCreateOffer(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      widget.isEdit ? SVKey.adminOfferUpdate : SVKey.adminOfferCreate,
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
}
