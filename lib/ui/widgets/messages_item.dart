import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../models/message.dart';

class MessagesItem extends StatelessWidget {
  final Message _message;

  final bool isUserMassage;

  const MessagesItem(this._message, this.isUserMassage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection:
                isUserMassage ? TextDirection.rtl : TextDirection.ltr,
            children: <Widget>[
              isUserMassage
                  ? SizedBox()
                  : Card(
                      elevation: 10,
                      color: isUserMassage
                          ? Theme.of(context).primaryColor.withOpacity(.8)
                          : Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(isUserMassage ? 20 : 0),
                          bottomLeft: Radius.circular(isUserMassage ? 0 : 20),
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
                crossAxisAlignment: isUserMassage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  isUserMassage
                      ? SizedBox()
                      : Container(
                          padding: isUserMassage
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
                      alignment: isUserMassage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(isUserMassage ? 20 : 0),
                            bottomRight:
                                Radius.circular(isUserMassage ? 0 : 20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          color: isUserMassage
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
