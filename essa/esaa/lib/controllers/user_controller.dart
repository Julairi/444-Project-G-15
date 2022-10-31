import 'package:esaa/models/models.dart';
import 'package:esaa/services/services.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  final Rx<User> user = User.empty().obs;
  final RxList<Review> reviews = <Review>[].obs;

  final RxInt _currentIndex = 2.obs;
  final RxBool isLoading = false.obs;

  void bindUser() {
    user.bindStream(UserDatabase(Auth().uID).user);
  }

  void bindUserWithID(String userID) {
    user.bindStream(UserDatabase(userID).user);
  }

  void bindReviews() {
    reviews.bindStream(ReviewDatabase(Auth().uID).reviews);
  }

  void bindReviewsWithID(String userID) {
    reviews.bindStream(ReviewDatabase(userID).reviews);
  }

  void clearAll(){
    user.value = User.empty();
    reviews.value = [];
  }


  void changePage(int index){
    _currentIndex.value = index;
  }

  int get currentIndex => _currentIndex.value;
}
