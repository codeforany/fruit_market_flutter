import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/admin/my_account/unit/admin_unit_add_screen.dart';
import 'package:fruitmarket/screen/admin/my_account/unit/admin_unit_row.dart';

class AdminUnitListScreen extends StatefulWidget {

  const AdminUnitListScreen({super.key});

  @override
  State<AdminUnitListScreen> createState() =>
      _AdminUnitListScreenState();
}

class _AdminUnitListScreenState extends State<AdminUnitListScreen> {
  List unitArr = [];


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
          "Units",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(AdminUnitAddScreen(
                
              ));
              apiCallingList();
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: unitArr.isEmpty
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
                var obj = unitArr[index];

                return AdminUnitRow(
                  obj: obj,
                  onPressed: () {},
                  onEdit: () async {
                    await context.push(AdminUnitAddScreen(
                      isEdit: true,
                      obj: obj,
                    ));
                    apiCallingList();
                  },
                  onDelete: () {
                    mdShowAlertTowButton(
                        Globs.appName, "Are you sure want to delete?", () {
                      apiCallDelete({
                        'unit_id': obj["unit_id"].toString(),
                      });
                    }, () {});
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
              itemCount: unitArr.length,
            ),
    );
  }

  //TODO: ApiCalling
  void apiCallingList() {
    Globs.showHUD();

    ServiceCall.post(
      {},
      SVKey.adminUnitList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          unitArr = responseObj[KKey.payload] as List? ?? [];
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
      SVKey.adminUnitDelete,
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
