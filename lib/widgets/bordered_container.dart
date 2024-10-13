import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/strings.dart';

import '../utils/app_colors.dart';

class BorderedContainer extends StatelessWidget {
  final Widget? child;
  final String? title;
  final Widget? body;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const BorderedContainer(
      {super.key, this.child, this.title, this.body, this.height, this.width, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorLightGrey,
          width: 1.2,
        ),
      ),
      child: child ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '',
                  style: smallTitleStyle.copyWith(fontWeight: FontWeight.bold, fontFamily: fontMedium)),
              const Divider(color: colorLightGrey, thickness: 1.5),
              SizedBox(height: 4.h),
              body ?? const SizedBox(),
            ],
          ),
    );
  }
}
