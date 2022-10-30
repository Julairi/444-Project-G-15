import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esaa/app.dart';
import 'package:esaa/config/constants.dart';
import 'package:esaa/controllers/controllers.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/chat/chat.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:esaa/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationScreen extends StatefulWidget {
  final Order? order;
  final Post? post;
  final Conversation? conversation;
  ConversationScreen({this.conversation, this.order, this.post, Key? key}) : super(key: key){
    Get.put(ConversationController());

    String recipient = "";
    if(conversation != null) {
      for(String member in conversation!.members){
        if(member != App.user.id){
          recipient = member;
        }
      }

      Get.find<ConversationController>().bindConversationWithID(conversation!.id);

    }else if(order != null && post != null){
      recipient = App.user.userType == "jobSeeker" ? post!.companyID : order!.userID;

      Get.find<ConversationController>().bindConversationWithOrderID(order!.id);
    }

    Get.find<ConversationController>().bindRecipientWithID(recipient);
  }

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConversationController>();

    final scrollController = ScrollController();

    final TextEditingController messageController = TextEditingController();

    return CustomAppbar(
        title: GetX<ConversationController>(
          builder: (controller) {
            return Text(
                controller.recipient.value.name,
                style: const TextStyle(
                    color: kFillColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis)
            );
          }
        ),
        showLeading: true,
        collapsable: false,
        child: GestureDetector(
          onTap: () => FocusManager().primaryFocus?.unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 30),

                      Expanded(
                        child: GetX<ConversationController>(
                          builder: (controller) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if(scrollController.hasClients) {
                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.fastOutSlowIn
                                );
                              }
                            });
                            return CustomListView(
                                controller: scrollController,
                                query: MessageDatabase.messagesCollection
                                    .where("conversationID", isEqualTo: controller.conversation.value.id)
                                    .orderBy("timestamp", descending: false),
                                emptyListWidget: const SizedBox(
                                  height: 300,
                                  child: Center(
                                    child: Text(
                                      "No message yet",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, querySnapshot) {
                                  Message message = Message.fromDocumentSnapshot(querySnapshot);
                                  return MessageItem(message: message);
                                });
                          }
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(width: 15),

                            Expanded(
                              child: Container(
                                constraints: const BoxConstraints(
                                    minHeight: 46,
                                    maxHeight: 140,
                                    minWidth: double.infinity,
                                    maxWidth: double.infinity
                                ),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(28)
                                    ),
                                    color: kFillColor
                                ),
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: messageController,
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: kFillColor,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent),
                                            ),
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                                            hintText: "Message",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                          onChanged: (value) => controller.message.value = value,
                                          keyboardType: TextInputType.text,
                                          cursorColor: kPrimaryColor,
                                          maxLines: null,
                                          style: const TextStyle(
                                              color: kTextColor,
                                              fontSize: 18,
                                              height: 1.1
                                          ),
                                        )
                                      ]
                                  ),
                                ),
                              )
                            ),

                            const SizedBox(width: 10),

                            MaterialButton(
                              height: 46,
                              minWidth: 46,
                              shape: const CircleBorder(),
                              elevation: 0,
                              padding: EdgeInsets.zero,
                              color: kPrimaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.send,
                                  color: kFillColor,
                                  size: 22,
                                ),
                              ),
                              onPressed: () => _sendMessage(controller, messageController)
                            ),

                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ));
  }

  Future<void> _sendMessage(ConversationController controller, TextEditingController messageController) async {
    if(controller.message.value.isNotEmpty && controller.conversation.value.id.isNotEmpty){

      final now = DateTime.now();
      final message =  controller.message.value;

      controller.message.value = "";
      messageController.text = "";

      final messageID = await MessageDatabase().addMessage(
        Message(
          conversationID: controller.conversation.value.id,
          details: message,
          senderID: App.user.id,
          receiverID: controller.recipient.value.id,
          senderImageUrl: App.user.imgUrl,
          timestamp: now
        ).toMap()
      );

      if(messageID == "") return;

      await ConversationDatabase().updateConversationDetails({
        "id": controller.conversation.value.id,
        "messages": FieldValue.arrayUnion([messageID]),
        "lastUpdated": now,
      });

    }
  }
}
