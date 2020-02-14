import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/message.dart';

class ChatItem extends StatelessWidget {
  final Message _message;

  final bool isSameSender;

  const ChatItem(this._message, this.isSameSender);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isSameSender ? TextDirection.rtl : TextDirection.ltr,
            children: <Widget>[
              Card(
                elevation: 10,
                color: isSameSender
                    ? Theme.of(context).primaryColor.withOpacity(.8)
                    : Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(isSameSender ? 20 : 0),
                    bottomLeft: Radius.circular(isSameSender ? 0 : 20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    _message.senderName.substring(0, 1).toUpperCase(),
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: isSameSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  isSameSender
                      ? SizedBox()
                      : Container(
                          padding: isSameSender
                              ? const EdgeInsets.only(right: 15)
                              : const EdgeInsets.only(left: 15),
                          child: FittedBox(
                            child: Text(
                              _message.senderName,
                              style: Theme.of(context).textTheme.title.copyWith(
                                    color: Colors.black.withOpacity(.6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Align(
                      alignment: isSameSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(isSameSender ? 20 : 0),
                            bottomRight: Radius.circular(isSameSender ? 0 : 20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          color: isSameSender
                              ? Theme.of(context).primaryColor.withOpacity(.8)
                              : Theme.of(context).accentColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _message.content,
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                DateFormat('HH:mm')
                                    .format(_message.date)
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(.9),
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
