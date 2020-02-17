import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';
import '../../models/message.dart';
import '../../constants.dart';
import '../../data/socket_io_manager.dart';
import '../widgets/messages_item.dart';
import '../widgets/messages_form.dart';

class ChatScreen extends StatefulWidget {
  final String senderName;

  const ChatScreen(this.senderName);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController;

  SocketIoManager _socketIoManager;

  bool _isTyping = false;
  String _userNameTyping;

  void _sendMessage(String messageContent) {
    _socketIoManager.sendMessage(
      'send_message',
      Message(
        widget.senderName,
        messageContent,
        DateTime.now(),
      ).toJson(),
    );

    Provider.of<MessagesProvider>(context, listen: false)
        .addMessage(Message(widget.senderName, messageContent, DateTime.now()));
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _socketIoManager = SocketIoManager(serverUrl: SERVER_URL)
      ..init()
      ..subscribe('receive_message', (Map<String, dynamic> data) {
        Provider.of<MessagesProvider>(context, listen: false)
            .addMessage(Message.fromJson(data));
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.bounceInOut,
        );
      })
      ..subscribe('typing', (Map<String, dynamic> data) {
        _userNameTyping = data['senderName'];
        setState(() {
          _isTyping = true;
        });
      })
      ..subscribe('stop_typing', (Map<String, dynamic> data) {
        setState(() {
          _isTyping = false;
        });
      })
      ..connect();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<MessagesProvider>(
              builder: (_, messagesProvider, __) => ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemCount: messagesProvider.allMessages.length,
                itemBuilder: (ctx, index) => MessagesItem(
                  messagesProvider.allMessages[index],
                  messagesProvider.allMessages[index]
                      .isUserMessage(widget.senderName),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isTyping,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '$_userNameTyping is typing',
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                  ),
                  Lottie.asset(
                    'assets/animations/chat-typing-indicator.json',
                    width: 40,
                    height: 40,
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
          ),
          MessageForm(
            onSendMessage: _sendMessage,
            onTyping: () {
              _socketIoManager.sendMessage(
                  'typing', json.encode({'senderName': widget.senderName}));
            },
            onStopTyping: () {
              _socketIoManager.sendMessage('stop_typing',
                  json.encode({'senderName': widget.senderName}));
            },
          ),
        ],
      ),
    );
  }
}
