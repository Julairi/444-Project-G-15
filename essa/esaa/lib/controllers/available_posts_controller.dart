import 'package:get/get.dart';

class AvailablePostsController extends GetxController {
  final RxString _searchField = "".obs;
  final RxString _filterBy = "date".obs;

  final RxInt matches = 0.obs;

  String get searchField => _searchField.value;

  String get filterBy => _filterBy.value;

  set searchField(String value) {
    _searchField.value = value;
  }

  set filterBy(String value) {
    _filterBy.value = value;
  }
}
