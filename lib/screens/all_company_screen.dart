import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/companies_controller.dart';
import 'package:eservices/screens/nav_explore_screen.dart';
import 'package:eservices/widgets/category_item_card.dart';
import 'package:eservices/widgets/company_item_card.dart';
import 'package:eservices/widgets/text_back_button.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';

class AllCompanyScreen extends StatelessWidget {
  const AllCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextBackButton(text: terms?.allCompany ?? "All Company")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<CompaniesController>(builder: (controller) {
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
                itemCount: controller.companies?.length ?? 0,
                itemBuilder: (context, index) {
                  final company = controller.companies?[index];
                  return CompanyItemCard(
                    margin: EdgeInsets.zero,
                    logo: company?.logo ?? '',
                    name: company?.name ?? "Companies",
                    onTap: () {
                      Get.to(
                        () => NavExploreScreen(
                          selectedCompany: company?.id.toString(),
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
