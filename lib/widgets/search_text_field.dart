import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/screens/filter_screen.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/image_paths.dart';
import 'filled_icon_button.dart';

class SearchTextField extends StatelessWidget {
  final VoidCallback? onTapFilter;
  final String? hintText;
  final bool greyColor;
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchTextField({
    Key? key,
    required this.controller,
    required this.onSearch,
    this.onTapFilter,
    this.greyColor = false,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: greyColor ? colorBlackLighter : colorWhite.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(50).r,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onSearch,
            icon: SvgPicture.asset(
              search,
              color: greyColor ? colorBlackLighter : colorWhite,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: appTextStyle.copyWith(
                color: greyColor ? colorBlack : colorWhite,
              ),
              decoration: InputDecoration(
                hintText: hintText ?? "Search for jobs",
                contentPadding: EdgeInsets.only(bottom: 3.h),
                border: InputBorder.none,
              ),
                onSubmitted: (_) => onSearch(),
            ),
          ),
          FilledIconButton(
            color: greyColor
                ? colorBlackLighter.withOpacity(0.2)
                : colorWhite.withOpacity(0.1),
            shape: const CircleBorder(),
            svgIcon: filter,
            iconColor: colorBlackLighter,
            onTap: onTapFilter ?? () => Get.to(FilterScreen()),
          ),
        ],
      ),
    );
  }
}