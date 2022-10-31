import 'package:esaa/models/models.dart';
import 'package:esaa/services/services.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {

  final Rx<User> recipient = User.empty().obs;

  final Rx<Conversation> conversation = Conversation.empty().obs;

  final RxString message = "".obs;

  void bindUser() {
    recipient.bindStream(UserDatabase(Auth().uID).user);
  }

  void bindRecipientWithID(String userID) {
    recipient.bindStream(UserDatabase(userID).user);
  }

  void bindConversationWithID(String conversationID) {
    conversation.bindStream(ConversationDatabase().getConversationAsStream(conversationID));
  }

  void bindConversationWithOrderID(String orderID) {
    conversation.bindStream(ConversationDatabase().getConversationsByOrderID(orderID));
  }


  void clearAll(){
    recipient.value = User.empty();
    conversation.value = Conversation.empty();
  }
}
