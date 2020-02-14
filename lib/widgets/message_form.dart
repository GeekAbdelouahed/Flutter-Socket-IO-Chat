import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageForm extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageForm({this.onSendMessage});

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  TextEditingController _textEditingController;

  void _sendMessage() {
    if (_textEditingController.text.isEmpty) return;

    widget.onSendMessage(_textEditingController.text);
    setState(() {
      _textEditingController.text = "";
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: TextField(
                  onSubmitted: (_) {
                    _sendMessage();
                  },
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Enter your message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              child: IconButton(
                onPressed: _sendMessage,
                icon: Icon(FontAwesomeIcons.telegramPlane),
                color: Theme.of(context).primaryColor,
                iconSize: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
