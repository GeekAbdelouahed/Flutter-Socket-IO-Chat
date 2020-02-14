import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class SocketIoManager {
  SocketIO _socketIO;

  SocketIoManager({@required String serverUrl, String nameSpace = '/'}) {
    _socketIO = SocketIOManager().createSocketIO(serverUrl, nameSpace);
  }

  void init() {
    _socketIO.init();
  }

  void subscribe(String channel, Function(Map<String, dynamic>) onGetData) {
    _socketIO.subscribe(channel, (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      onGetData(data);
    });
  }

  void connect() {
    _socketIO.connect();
  }

  void sendMessage(String channel, String message) {
    _socketIO.sendMessage(channel, message);
  }

  void disconnect() {
    _socketIO.disconnect();
  }
}
