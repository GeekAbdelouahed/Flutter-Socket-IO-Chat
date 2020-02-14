import 'package:flutter/foundation.dart';

import '../models/message.dart';

class MessagesProvider with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get allMessages => [..._messages];

  void addMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
