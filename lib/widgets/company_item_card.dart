import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/widgets/my_network_image.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CompanyItemCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String logo;
  final String name;
  final VoidCallback? onTap; // Add this line

  const CompanyItemCard(
      {super.key,
      required this.name,
      this.margin,
      required this.logo,
      this.onTap}); // Add this line});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap, // Use the onTap callback
      child: Container(
        margin: margin ?? EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.all(8.r).copyWith(right: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colorPrimary.withOpacity(0.1), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name, style: appTitleStyle.copyWith(fontSize: 14)),
            SizedBox(height: 5.h),
            MyImage(imageUrl: logo, height: 30.h),
            //Text(subTitle, style: appSubTextStyle.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
