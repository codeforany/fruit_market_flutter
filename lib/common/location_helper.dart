

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruitmarket/common/common_extension.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';

class LocationHelper {

  static final LocationHelper singleton =  LocationHelper.internal();
  LocationHelper.internal();
  factory LocationHelper() => singleton;
  static LocationHelper shared() => singleton;


  final GeolocatorPlatform geocodingPlatform = GeolocatorPlatform.instance;

  StreamSubscription<Position>? positionStreamSub;
  StreamSubscription<ServiceStatus>? serviceStatusStreamSub;
  bool positionStreamStarted = true;

  Position? lastLocation;
  bool isSaveFileLocation = false;
  int saveId = 0;

  String saveFilePath = "";

  void startInit() async {

    var isAccess = await handlePermission();

    if(!isAccess) {
      return;
    }

    saveFilePath = (await getSavePath()).path;

    if( serviceStatusStreamSub == null ) {

      final serviceStatusStream = geocodingPlatform.getServiceStatusStream();
      serviceStatusStreamSub = serviceStatusStream.handleError( (error) {

        serviceStatusStreamSub?.cancel();
        serviceStatusStreamSub = null;

      } ).listen( (serviceStatus) {

        String serviceStatusValue;

        if(serviceStatus ==  ServiceStatus.enabled) {

          if(positionStreamStarted) {
            //Start Location Listen Logic

            locationChangedListening();
          }
          serviceStatusValue = "enabled";

        }else{
           if(positionStreamSub != null) {
            positionStreamSub?.cancel();
            positionStreamSub = null;

            debugPrint( "Position Stream Cancel" );

            serviceStatusValue = "disabled";
           }
        }

      } );
    }

  }

  void locationSendStart(){
    if(positionStreamStarted) {
      return;
    }

    locationChangedListening();
  }

  void locationSendPause() {
    if(positionStreamSub != null) {
      positionStreamStarted = false;
      positionStreamSub?.cancel();
      positionStreamSub = null;
    }
  }

  Future<bool> handlePermission() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable =  await geocodingPlatform.isLocationServiceEnabled();

    if(!serviceEnable) {
      return false;
    }

    permission =  await geocodingPlatform.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await geocodingPlatform.requestPermission();
      if(permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }


  void locationChangedListening() {

      if( positionStreamSub == null ) {
        final positionStream = geocodingPlatform.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 15
          )
        );

        positionStreamSub = positionStream.handleError( (error) {

          positionStreamSub?.cancel();
          positionStreamSub = null;

        } ).listen( (position) {

          lastLocation = position;

          if(isSaveFileLocation && saveId != 0) {
            try {

              File("$saveFilePath/$saveId.txt").writeAsStringSync(',{"latitude":${ position.latitude },"longitude":${ position.longitude },"time":"${  DateTime.now().stringFormat(format: "yyyy-MM-dd HH:mm:ss" ) }"}', mode: FileMode.append);
              
            } catch (e) {
              debugPrint(e.toString());
            }
          }
          //Api Calling
        } );

      }

  }

  void startSaveLocationFile(int saveId, Position position) {

    saveId = saveId;

    try {
      File("$saveFilePath/$saveId.txt").writeAsStringSync(
          '{"latitude":${position.latitude},"longitude":${position.longitude},"time":"${DateTime.now().stringFormat(format: "yyyy-MM-dd HH:mm:ss")}"}',
          mode: FileMode.append);
      debugPrint("Location Save Started");
      isSaveFileLocation = true;
          
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  void stopSaveLocationFile(){
    isSaveFileLocation = false;
    saveId = 0;
  }


  Future<Directory> getSavePath() async {
    if(Platform.isAndroid) {
      return getTemporaryDirectory();
    }else{
      return getApplicationCacheDirectory();
    }
  }

  String getSaveLocationJsonString(int id) {
    try {

      return "[${ File("$saveFilePath/$id.txt").readAsStringSync() }]" ;
    }catch (e) {
      debugPrint(e.toString());
      return "[]";
    }
  }

}