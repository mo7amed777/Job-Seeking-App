import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/utils/image_paths.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class TextBackButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool white;
  //final Color? iconColor;
  //final TextStyle? textStyle;
  const TextBackButton(
      {super.key,
      //this.iconColor, this.textStyle,
      required this.text,
      this.white = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap ?? () => Get.back(),
      // icon: Icon(
      //   Icons.arrow_back_ios_new,
      //   color: white ? colorWhite : colorBlack,
      //   size: 20,
      // ),
      icon: SvgPicture.asset(arrowBack, color: white ? colorWhite : colorBlack),
      label: Text(text,
          style: white
              ? smallTitleStyle.copyWith(color: colorWhite)
              : smallTitleStyle),
    );
  }
}
