// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'constant.dart';
import 'data_model.dart';

class SocketService {
  final StreamController<DataModel> streamController =
      StreamController<DataModel>.broadcast();

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

  void init() {
    socket!.connect();
    socket!.onConnect((data) {
      log("Socket Bağlandı!!", name: "SocketService");
      socket!.emit("orderJoin", "46");
      returnData();
    });
  }

  returnData() {
    socket!.on('courierLocation', (data) {
      streamController.sink.add(DataModel.fromMap(data));
    });
  }
}
