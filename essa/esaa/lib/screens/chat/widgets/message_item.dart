import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  const MessageItem({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSender = message.senderID == App.user.id;

    if(!message.hasBeenRead && !isSender) _markAsRead();

    final now = DateTime.now();
    final wasMessageSentToday = message.timestamp.day == now.day
      && message.timestamp.month == now.month
      && message.timestamp.year == now.year;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth * 0.8,
                    minHeight: 42
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: isSender ? kPrimaryColor : kPrimaryLightColor
                  ),
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.details,
                        style: TextStyle(
                          color: isSender ? kFillColor : kTextColor,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 3),


                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          if(isSender)
                            SizedBox(width: wasMessageSentToday ? 50 : 30),

                          Text(
                            DateFormat("${wasMessageSentToday ? "" : "dd/mm/yy "}hh:mm aa").format(message.timestamp),
                            style: TextStyle(
                              color: isSender ? Colors.white70 : Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                          if(isSender)
                            const SizedBox(width: 3),

                          if(isSender)
                            Icon(
                              Icons.done_all,
                              color: message.hasBeenRead ? Colors.lightBlueAccent : Colors.white70,
                              size: 16,
                            ),

                          if(!isSender)
                            SizedBox(width: wasMessageSentToday ? 50 : 30),

                        ],
                      )


/*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                        ],
                      )*/
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  void _markAsRead() async {
    message.hasBeenRead = true;
    await MessageDatabase().updateMessageDetails({
      "id": message.id,
      "hasBeenRead": message.hasBeenRead,
    });
  }
}
