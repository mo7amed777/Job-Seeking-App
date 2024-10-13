import 'package:get/get.dart';

import '../models/slider_model.dart';
import '../services/api_caller.dart';
import '../services/urls.dart';

class SliderController extends GetxController {
  bool loading = false;

  SliderModel sliderModel = SliderModel();
  List<Slide>? get slides => sliderModel.slides;

  Future<void> getSlides() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.appSliders);
    final responseData = await response.responseData;
    if (response.isSuccess) {
      sliderModel = SliderModel.fromJson(responseData);
    } else {
      //customSnackbar('Error', "Failed to get data", 'error');
    }
    loading = false;
    update();
  }
}
