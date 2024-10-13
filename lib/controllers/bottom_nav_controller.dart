import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;

  void changeScreen(index) {
    currentIndex = index;
    update();
  }

  void backToHome() {
    currentIndex = 0;
    update();
  }
}
