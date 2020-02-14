import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/messages_provider.dart';
import '../widgets/chat_item.dart';
import '../models/message.dart';
import '../constants.dart';
import '../socket_io_manager.dart';
import '../widgets/message_form.dart';

class ChatScreen extends StatefulWidget {
  final String senderName;

  const ChatScreen(this.senderName);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController;

  SocketIoManager _socketIoManager;

  void _sendMessage(String messageContent) {
    _socketIoManager.sendMessage(
      'send_message',
      json.encode(Message(
        widget.senderName,
        messageContent,
        DateTime.now(),
      ).toJson()),
    );

    Provider.of<MessagesProvider>(context, listen: false)
        .addMessage(Message(widget.senderName, messageContent, DateTime.now()));
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _socketIoManager = SocketIoManager(serverUrl: SERVER_URL);

    _socketIoManager.init();

    _socketIoManager.subscribe('receive_message', (Map<String, dynamic> data) {
      Provider.of<MessagesProvider>(context, listen: false)
          .addMessage(Message.fromJson(data));
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      );
    });

    _socketIoManager.connect();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _socketIoManager.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.senderName),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<MessagesProvider>(
              builder: (_, messagesProvider, __) => ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemCount: messagesProvider.allMessages.length,
                itemBuilder: (ctx, index) => ChatItem(
                  messagesProvider.allMessages[index],
                  messagesProvider.allMessages[index].senderName ==
                      widget.senderName,
                ),
              ),
            ),
          ),
          MessageForm(onSendMessage: _sendMessage),
        ],
      ),
    );
  }
}
