// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/constants.dart';

class SocketService {
  static IO.Socket? socket;

  void connected() {
    socket = IO.io(
        socketUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    init();
  }

  static void init() {
    socket!.connect();
    socket!.onConnect((data) {
      log("Socket Bağlandı!!", name: "SocketService");
      socket!.emit("orderJoin", "46");
    });
  }
}
