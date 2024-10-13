import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eservices/utils/image_paths.dart';

import '../utils/app_colors.dart';

class BodyWidget extends StatelessWidget {
  final Widget child;
  final bool backButton;
  final bool deepColor;
  final Color? backButtonColor;
  const BodyWidget(
      {super.key,
      required this.child,
      this.backButton = false,
      this.backButtonColor,
      this.deepColor = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(deepColor ? bodyImage : bodyImageLight,
            height: double.infinity, width: double.infinity, fit: BoxFit.cover),
        backButton
            ? Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new,
                        color: backButtonColor ?? colorBlack),
                  ),
                ),
              )
            : const SizedBox(),
        child,
      ],
    );
  }
}
