import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/chat/chat.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';

class Conversations extends StatelessWidget {
  const Conversations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CustomAppbar(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              CustomListView(
                  query: ConversationDatabase.conversationsCollection
                      .where("members", arrayContains: App.user.id)
                      .orderBy("lastUpdated", descending: true),
                  emptyListWidget: const SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                        "No conversation yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  itemBuilder: (context, querySnapshot) {
                    Conversation conversation = Conversation.fromDocumentSnapshot(querySnapshot);
                    return ConversationItem(conversation: conversation);
                  }),
            ],
          ),
        )
    );
  }
}
