import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/screen/my_account/address_add_screen.dart';
import 'package:fruitmarket/screen/my_account/address_row.dart';

class AddressListScreen extends StatefulWidget {
  final bool isPicker;
  final Function(Map)? didSelect;
  const AddressListScreen({super.key, this.isPicker = false, this.didSelect});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List addressArr = [];

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
          "Address List",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(AddressAddScreen());
            },
            icon: Icon(
              Icons.add,
              color: TColor.whiteText,
            ),
          )
        ],
      ),
      body: addressArr.isEmpty
          ? Center(
              child: Text(
                "No Address List",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                var obj = addressArr[index];
                return AddressRow(
                  obj: obj,
                  onPressed: () {

                      if(widget.isPicker && widget.didSelect != null ) {
                          widget.didSelect!( obj );
                          context.pop();
                      }

                  },
                  onDelete: () {
                    apiCallingDelete(
                        {'address_id': obj["address_id"].toString()});
                  },
                  onEdit: () async {
                    await context.push(AddressAddScreen(
                      isEdit: true,
                      obj: obj,
                    ));
                    apiCallingList();
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.black26,
                height: 0.5,
              ),
              itemCount: addressArr.length,
            ),
    );
  }

  //TODO: ServiceCall

  void apiCallingList() {
    Globs.showHUD();
    ServiceCall.post(
      {},
      SVKey.addressList,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();

        if (responseObj[KKey.status].toString() == "1") {
          addressArr = responseObj[KKey.payload] as List? ?? [];

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

  void apiCallingDelete(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(
      parameter,
      SVKey.addressDelete,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();

        if (responseObj[KKey.status].toString() == "1") {
          apiCallingList();

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
}
