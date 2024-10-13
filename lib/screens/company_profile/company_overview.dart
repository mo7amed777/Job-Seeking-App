import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/company_details_controller.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/strings.dart';

import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../models/company_details_model.dart';

class CompanyOverview extends StatelessWidget {
  const CompanyOverview({super.key});

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    final controller = Get.find<CompanyDetailsController>();
    Company? company = controller.company;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(terms?.about ?? "About"),
          SizedBox(height: 8.h),
          const Text(overview, style: appTextStyle),
          SizedBox(height: 8.h),
          title(terms?.video ?? "Video"),
          SizedBox(height: 8.h),
          videoContainer(context),
          SizedBox(height: 8.h),
          title(terms?.address ?? "Address"),
          SizedBox(height: 8.h),
          addressOption(sms, company?.email ?? "email"),
          addressOption(call, company?.mobile ?? "mobile"),
          //addressOption(web, company?. ??"www.apex.com.bd"),
          addressOption(locationIcon, company?.address ?? "address"),
        ],
      ),
    );
  }

  Container videoContainer(BuildContext context) {
    return Container(
      height: 150.h,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: colorBlack, borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {},
        child: Center(
          child: CircleAvatar(
            radius: 25.r,
            backgroundColor: colorLightGreen.withOpacity(0.1),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: colorLightGreen,
              child: const Icon(Icons.play_arrow_rounded, color: colorWhite),
            ),
          ),
        ),
      ),
    );
  }

  Column addressOption(icon, text) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(icon, color: colorPrimary),
            SizedBox(width: 8.w),
            Text(text, style: appTextStyle)
          ],
        ),
        SizedBox(height: 5.h),
      ],
    );
  }

  Text title(text) => Text(text, style: smallTitleStyle);
}
