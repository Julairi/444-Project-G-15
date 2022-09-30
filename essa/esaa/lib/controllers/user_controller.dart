import 'package:esaa/models/models.dart';
import 'package:esaa/services/services.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  final Rx<User> user = User.empty().obs;

  final RxInt _currentIndex = 1.obs;
  final RxBool isLoading = false.obs;

  void bindUser() {
    user.bindStream(UserDatabase(Auth().uID).user);
  }

  void bindUserWithID(String userID) {
    user.bindStream(UserDatabase(userID).user);
  }

  clearAll(){
    user.value = User.empty();
  }


  void changePage(int index){
    _currentIndex.value = index;
  }

  int get currentIndex => _currentIndex.value;
}
