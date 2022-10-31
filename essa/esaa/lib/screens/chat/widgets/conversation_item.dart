import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/chat/view/conversation_screen.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationItem extends StatelessWidget {
  final Conversation conversation;
  const ConversationItem({required this.conversation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final fields = conversation.title.split('//');

    final title = '${App.user.userType == "jobSeeker" ? fields[1] : fields[0]} - ${fields[2]}';

    return InkWell(
        onTap: () => Get.to(() => ConversationScreen(conversation: conversation)),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 7,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      "https://i.pinimg.com/474x/6a/d3/66/6ad3663d79ccc962377d7a6cbe4d9bfe.jpg",
                      height: 50,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    child: Container(
                      height: 50,
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(255, 105, 110, 112).withOpacity(0),
                                const Color.fromARGB(255, 64, 69, 71).withOpacity(0.2)
                              ],
                              stops: const [0.6, 1]
                          )
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),

                          Text(
                            title,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 6, 6, 6),
                                fontSize: 18,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(
                      child: StreamBuilder<Message>(
                        stream: MessageDatabase().getLastMessage(conversation.id),
                        builder: (context, snapshot) {
                          final lastMessage =  snapshot.data ?? Message.empty();
                          return Text(
                            lastMessage.details == ""
                                ? "No message yet" : lastMessage.details,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: lastMessage.id.isNotEmpty && !lastMessage.hasBeenRead
                                  && lastMessage.senderID != App.user.id ? FontWeight.bold : FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          );
                        }
                      )
                    ),

                    StreamBuilder<int>(
                      stream: MessageDatabase().getUnreadMessages(conversation.id),
                      builder: (context, snapshot) {
                        final int unreadMessages = snapshot.data ?? 0;
                        if (unreadMessages > 0) {
                          return Container(
                            height: 30,
                            decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                shape: BoxShape.circle
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                unreadMessages.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: defaultFontSize,
                                    fontWeight: FontWeight.normal
                                ),

                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }
                    ),



                  ],
                ),
              )
            ],
          ),
        ));
  }
}
