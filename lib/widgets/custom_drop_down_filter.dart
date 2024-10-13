import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eservices/utils/image_paths.dart';

import '../utils/app_text_styles.dart';
import 'bordered_container.dart';

class CustomDropDownFilter extends StatelessWidget {
  final bool haveTitle;
  final bool havePrefix;
  final String? title;
  final String? hint;
  final List<MapEntry<String, String>> items;
  final void Function(String?) onChanged;
  final String? value; // Make value nullable
  final String? prefixIconSvg;

  const CustomDropDownFilter({
    super.key,
    this.haveTitle = true,
    this.title,
    required this.items,
    required this.onChanged,
    this.value, // Allow null
    this.havePrefix = false,
    this.prefixIconSvg,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (haveTitle) Text(title ?? '', style: smallTitleStyle),
        if (haveTitle) SizedBox(height: 8.h),
        BorderedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (havePrefix) SvgPicture.asset(prefixIconSvg ?? userIcon),
              if (havePrefix) SizedBox(width: 5.w),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    style: appTextStyleBlack,
                    isExpanded: true,
                    value: value,
                    hint: Text(hint ?? 'Select Option'),
                    items: items.map((MapEntry<String, String> item) {
                      return DropdownMenuItem<String>(
                        value: item.key,
                        child: Text(item.value),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
