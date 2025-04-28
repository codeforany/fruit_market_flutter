import 'package:flutter/material.dart';
import 'package:fruitmarket/common/color_extension.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:fruitmarket/common_widgets/round_button.dart';
import 'package:fruitmarket/common_widgets/round_textfield.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';

class AddressAddScreen extends StatefulWidget {
  final Map? obj;
  final bool isEdit;
  const AddressAddScreen({super.key, this.obj, this.isEdit = false});

  @override
  State<AddressAddScreen> createState() => _AddressAddScreenState();
}

class _AddressAddScreenState extends State<AddressAddScreen> {
  GeoPoint? selectPin;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtLatitude = TextEditingController();
  TextEditingController txtLongitude = TextEditingController();
  TextEditingController txtZipCode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isEdit) {
      txtName.text = widget.obj?["name"].toString() ?? "";
      txtAddress.text = widget.obj?["address"].toString() ?? "";
      txtCity.text = widget.obj?["city"].toString() ?? "";
      txtLatitude.text = widget.obj?["lati"].toString() ?? "";
      txtLongitude.text = widget.obj?["longi"].toString() ?? "";
      txtZipCode.text = widget.obj?["zip_code"].toString() ?? "";

      selectPin = GeoPoint(
          latitude: double.tryParse(txtLatitude.text) ?? 0.0,
          longitude: double.tryParse(txtLongitude.text) ?? 0.0);
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
         widget.isEdit ? "Edit Address" : "Add Address",
          style: TextStyle(
            color: TColor.whiteText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                hintText: "",
                controller: txtName,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                hintText: "",
                controller: txtAddress,
                minLine: 6,
                maxLine: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "City",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                hintText: "",
                controller: txtCity,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Zip Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RoundTextfield(
                hintText: "",
                controller: txtZipCode,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Latitude",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: TColor.primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Longitude",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: TColor.primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundTextfield(
                            hintText: "",
                            controller: txtLatitude,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: RoundTextfield(
                            hintText: "",
                            controller: txtLongitude,
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        var p = await showSimplePickerLocation(
                          context: context,
                          isDismissible: true,
                          title: "location picker",
                          textConfirmPicker: "pick",
                          zoomOption: const ZoomOption(
                            initZoom: 8,
                          ),
                          initPosition: selectPin,
                          radius: 8.0,
                        );
                        if (p != null) {
                          selectPin = p;
                          txtLatitude.text = p.latitude.toString();
                          txtLongitude.text = p.longitude.toString();

                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  p.latitude, p.longitude);

                          if (placemarks.isNotEmpty) {
                            var aObj = placemarks.first;
                            txtAddress.text =
                                "${aObj.name}, ${aObj.street}, ${aObj.subLocality}";

                            txtCity.text = "${aObj.subAdministrativeArea}";
                            txtZipCode.text = aObj.postalCode ?? "";
                          }

                          if (mounted) {
                            setState(() {});
                          }
                          // debugPrint(p);
                        }
                      },
                      icon: Icon(Icons.pin_drop))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                  title: widget.isEdit ? "Update" : "Add",
                  onPressed: () {
                    actionAdd();
                  }),
            ],
          ),
        ),
      )),
    );
  }

  //TODO: Action
  void actionAdd() {
    if (txtName.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter name", () {});
      return;
    }

    if (txtAddress.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter address", () {});
      return;
    }

    if (txtCity.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter city name", () {});
      return;
    }

    if (txtZipCode.text.isEmpty) {
      mdShowAlert(Globs.appName, "Please enter zip code", () {});
      return;
    }

    if (selectPin == null) {
      mdShowAlert(Globs.appName, "Please select location on map", () {});
      return;
    }

    apiCallingAddUpdate(widget.isEdit
        ? {
            'name': txtName.text,
            'address': txtAddress.text,
            'city': txtCity.text,
            'lati': txtLatitude.text,
            'longi': txtLongitude.text,
            'zip_code': txtZipCode.text,
            'address_id': widget.obj?["address_id"].toString() ?? "",
          }
        : {
            'name': txtName.text,
            'address': txtAddress.text,
            'city': txtCity.text,
            'lati': txtLatitude.text,
            'longi': txtLongitude.text,
            'zip_code': txtZipCode.text,
          });
  }

  //TODO: ServiceCall

  void apiCallingAddUpdate(Map<String, dynamic> parameter) {
    Globs.showHUD();
    ServiceCall.post(
      parameter,
      widget.isEdit ? SVKey.addressUpdate : SVKey.addressAdd,
      isTokenApi: true,
      withSuccess: (responseObj) async {
        Globs.hideHUD();

        if (responseObj[KKey.status].toString() == "1") {
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
      },
    );
  }
}
