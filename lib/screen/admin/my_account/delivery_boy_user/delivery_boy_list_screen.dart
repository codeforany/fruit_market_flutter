import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/admin/my_account/delivery_boy_user/delivery_boy_add_screen.dart';

class DeliveryBoyListScreen extends StatefulWidget {
  final bool isPicker;
  final Function(Map)? didSelect;
  const DeliveryBoyListScreen({super.key,  this.isPicker = false,  this.didSelect});

  @override
  State<DeliveryBoyListScreen> createState() => _DeliveryBoyListScreenState();
}

class _DeliveryBoyListScreenState extends State<DeliveryBoyListScreen> {
  List userArr = [];

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
          "Delivery Boy List",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(DeliveryBoyAddScreen());
              apiCallingList();
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: userArr.isEmpty
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              itemBuilder: (context, index) {
                var obj = userArr[index];

                return InkWell(
                  onTap: (){
                    if(widget.isPicker) {
                      if(widget.didSelect != null) {
                        widget.didSelect!(obj);

                      }
                      context.pop();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ]),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: TColor.primary,
                          size: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                obj["name"].toString(),
                                style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                               "${ obj["mobile_code"].toString() } ${obj["mobile"].toString()}" ,
                                style: TextStyle(
                                  color: TColor.placeholder,
                                  fontSize: 12,
                                ),
                              ),
                  
                              Text(
                                "Online (On Order Delivering)",
                                style: TextStyle(
                                  color: TColor.primary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                  
                        IconButton(
                          onPressed: () async {
                  
                              await context.push( DeliveryBoyAddScreen(isEdit: true, editObj: obj, ) );
                              apiCallingList();
                  
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
                              apiCallDelete({
                                'user_id': obj["user_id"].toString(),
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
                  ),
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  color: Colors.black26,
                  height: 1,
                ),
              ),
              itemCount: userArr.length,
            ),
    );
  }

  //TODO: ApiCalling
  void apiCallingList() {
    Globs.showHUD();

    ServiceCall.post(
      {},
      SVKey.adminDeliveryBoyUserList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          userArr = responseObj[KKey.payload] as List? ?? [];
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
      SVKey.adminDeliveryBoyUserDelete,
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

  
}
