import 'package:get/get.dart';
import 'package:eservices/models/categories_filter_model.dart';
import 'package:eservices/services/urls.dart';
import '../services/api_caller.dart';

class CategoriesFilterController extends GetxController {
  var loading = false.obs;
  var categoriesFilterModel = CategoriesFilterModel().obs;

  List<CategoryFilter>? get categoriesFilter =>
      categoriesFilterModel.value.categoryFilterList?.categoriesFilter;

  var selectedCategory = Rxn<String>();

  @override
  void onInit() {
    getCategoriesFilter();
    super.onInit();
  }

  Future<void> getCategoriesFilter() async {
    loading.value = true;

    final response = await ApiCaller().getRequest(Urls.filterCategories);

    if (response.isSuccess) {
      categoriesFilterModel.value =
          CategoriesFilterModel.fromJson(response.responseData);
    }

    loading.value = false;
  }
}
