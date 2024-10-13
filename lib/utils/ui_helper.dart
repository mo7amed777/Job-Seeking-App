import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class UiHelper {
  static showSnackBar({bool error = false, required String text}) {
    Get.snackbar(
      error ? "Failed" : "Success",
      text,
      backgroundColor: error ? colorRed.withOpacity(0.2) : colorPrimary.withOpacity(0.5),
      duration: const Duration(seconds: 2),
    );
  }

  static loadingIndicator() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      //backgroundColor: Colors.transparent,
      content: const Center(
        child: Column(
          children: [
            CupertinoActivityIndicator(radius: 12),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
