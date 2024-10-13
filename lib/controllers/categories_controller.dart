import 'package:get/get.dart';
import 'package:job_nect/models/categories_model.dart';
import 'package:job_nect/services/urls.dart';
import '../services/api_caller.dart';

class CategoriesController extends GetxController {
  bool loading = false;
  CategoriesModel categoriesModel = CategoriesModel();

  List<Category>? get categories => categoriesModel.categoryList?.categories;

  Future<void> getCategories() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.categories);
    if (response.isSuccess) {
      categoriesModel = CategoriesModel.fromJson(response.responseData);
    } else {
      // Handle the error case if necessary
    }
    loading = false;
    update();
  }
}
