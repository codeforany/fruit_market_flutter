import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fruitmarket/common/globs.dart';
import 'package:fruitmarket/common/service_call.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager sigleton = SocketManager._internal();

  SocketManager._internal();
  IO.Socket? socket;
  static SocketManager get shared => sigleton;

  void initSocket() {
    socket = IO.io(SVKey.nodeUrl, {
      "transports": ['websocket'],
      "autoConnect": true
    });

    socket?.on("connect", (data) {
      if(kDebugMode) {
        print("Socket Connect Done");
      }

    //TODO: User Are Logined

    
      //updateSocketApi();
    });

    socket?.on("connect_error", (data) {
      if (kDebugMode) {
        print("Socket Connect Error");
      }
    });

    socket?.on("error", (data) {
      if (kDebugMode) {
        print("Socket Error");
        print(data);
      }
    });

    socket?.on("error", (data) {
      if (kDebugMode) {
        print("Socket Error");
      }
    });

    socket?.on("disconnect", (data) {
      if (kDebugMode) {
        print("Socket disconnect");
      }
    });

    socket?.on("UpdateSocket", (data) {
      if (kDebugMode) {
        print("UpdateSocket");
        print(data);
      }
    });
  }

  Future updateSocketApi() async {
    try {
      socket?.emit("UpdateSocket", jsonEncode({'access_token': ServiceCall.userObj["auth_token"].toString()  }) );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
