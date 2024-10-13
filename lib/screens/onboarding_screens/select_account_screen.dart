import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/screens/onboarding_screens/welcome_screen.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/ui_helper.dart';
import 'package:eservices/widgets/appbar_back_button.dart';

import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';

class SelectAccountScreen extends StatefulWidget {
  const SelectAccountScreen({super.key});

  @override
  State<SelectAccountScreen> createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {
  static Terms? terms = LocalTextController.terms;
  List images = [job, employee];
  List titles = [terms?.iWantJob, terms?.iWantEmployee];
  //List titles = [terms?.iWantJob,terms?.iWantEmployee "I want Job", "I want Employee"];
  int? selectedIndex;
  late String accountType;
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        //leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new)),
        leading: const AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              selectAccountType,
              //height: 250.h,
              width: mq.width / 1.1,
            ),
            SizedBox(height: 30.h),
            Text(
              terms?.selectAccountTitle ?? 'selectAccountTitle',
              textAlign: TextAlign.center,
              style: largeTitleStyle,
            ),
            SizedBox(height: 10.h),
            Text(
              terms?.selectAccountSub ?? 'selectAccountTitle',
              textAlign: TextAlign.center,
              style: appTextStyle,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 120.h,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.4 / 1),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12).r,
                      onTap: () {
                        selectedIndex = index;
                        accountType =
                            selectedIndex == 0 ? "Employee" : "Recruiter";
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10).r,
                        margin: EdgeInsets.only(
                            right: index == 0 ? 8.w : 0,
                            left: index == 1 ? 8.w : 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12).r,
                          border: Border.all(
                              width: selectedIndex == index ? 1.5 : 1,
                              color: selectedIndex == index
                                  ? colorPrimary
                                  : colorLightGrey),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(images[index],
                                height: 50.h, width: 50.w),
                            SizedBox(height: 10.h),
                            Text(
                              titles[index],
                              style: appTitleStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            // Row(
            //   children: List.generate(
            //     images.length,
            //     (index) => InkWell(
            //       borderRadius: BorderRadius.circular(12).r,
            //       onTap: () {
            //         selectedIndex = index;
            //         accountType = selectedIndex == 0 ? "Employee" : "Recruiter";
            //         setState(() {});
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.all(20).r,
            //         margin: EdgeInsets.only(right: index == 0 ? 8.w : 0, left: index == 1 ? 8.w : 0),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12).r,
            //           border: Border.all(
            //               width: selectedIndex == index ? 1.5 : 1,
            //               color: selectedIndex == index ? colorPrimary : colorLightGrey),
            //         ),
            //         child: Column(
            //           children: [
            //             Image.asset(images[index], height: 50.h, width: 50.w),
            //             SizedBox(height: 10.h),
            //             Text(
            //               titles[index],
            //               style: appTitleStyle,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            //SizedBox(height: 10.h),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onTap: () => Get.back(),
              text: terms?.back ?? "Back",
              backgroundColor: colorPrimaryLight,
              foregroundColor: colorPrimary,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              onTap: () {
                if (selectedIndex != null) {
                  Get.to(WelcomeScreen(accType: accountType));
                } else {
                  UiHelper.showSnackBar(
                      text: "please select account type first", error: true);
                  //Get.snackbar("Error", "please select account type first");
                }
              },
              text: terms?.next ?? "Next",
            ),
          ),
        ],
      ),
    );
  }
}
