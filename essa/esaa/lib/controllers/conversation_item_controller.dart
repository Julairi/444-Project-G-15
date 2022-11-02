import 'package:esaa/models/models.dart';
import 'package:esaa/services/services.dart';
import 'package:get/get.dart';

class ConversationItemController extends GetxController {
  final RxInt unreadMessages = 0.obs;

  final Rx<Message> lastMessage = Message.empty().obs;

  void bindUnreadMessages(String conversationID) {
    unreadMessages
        .bindStream(MessageDatabase().getUnreadMessages(conversationID));
  }

  void bindLastMessage(String conversationID) {
    lastMessage.bindStream(MessageDatabase().getLastMessage(conversationID));
  }

  void clearAll() {
    unreadMessages.value = 0;
    lastMessage.value = Message.empty();
  }
}
