import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class SocketIoManager {
  SocketIO _socketIO;

  SocketIoManager(
      {@required String serverUrl,
      String nameSpace = '/',
      String query,
      Function socketStatusCallback}) {
    _socketIO = SocketIOManager().createSocketIO(serverUrl, nameSpace,
        query: query, socketStatusCallback: socketStatusCallback);
  }

  Future<void> init() => _socketIO.init();

  Future<void> subscribe(
          String channel, Function(Map<String, dynamic>) onGetData) =>
      _socketIO.subscribe(channel, (jsonData) {
        Map<String, dynamic> data = json.decode(jsonData);
        onGetData(data);
      });

  Future<void> connect() => _socketIO.connect();

  Future<void> sendMessage(String channel, String message) =>
      _socketIO.sendMessage(channel, message);

  Future<void> disconnect() => _socketIO.disconnect();
}
