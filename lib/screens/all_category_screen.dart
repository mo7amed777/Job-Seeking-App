import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/categories_controller.dart';
import 'package:eservices/screens/nav_explore_screen.dart';
import 'package:eservices/widgets/category_item_card.dart';
import 'package:eservices/widgets/text_back_button.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextBackButton(text: terms?.allCategory ?? "All Category")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<CategoriesController>(builder: (controller) {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16).copyWith(top: 5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.6,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w),
                itemCount: controller.categories?.length ?? 0,
                itemBuilder: (context, index) {
                  final category = controller.categories?[index];
                  return CategoryItemCard(
                    margin: EdgeInsets.zero,
                    iconImage: category?.iconUrl ?? '',
                    title: category?.name ?? "Categories",
                    onTap: () {
                      Get.to(
                        () => NavExploreScreen(
                          selectedCategory: category?.id.toString(),
                        ),
                      );
                    },
                  );
                },
              );
            }),
            // GetBuilder<CategoriesController>(builder: (controller) {
            //   return Padding(
            //     padding: const EdgeInsets.only(left: 16, right: 8),
            //     child: Wrap(
            //       runSpacing: 10.h,
            //       children: controller.categories!
            //           .map((e) => CategoryItemCard(title: e.name ?? '', iconImage: e.iconUrl ?? ''))
            //           .toList(),
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
