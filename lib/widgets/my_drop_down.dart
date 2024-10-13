import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_nect/utils/image_paths.dart';

import '../utils/app_text_styles.dart';
import 'bordered_container.dart';

class MyDropDown extends StatelessWidget {
  final bool haveTitle;
  final bool havePrefix;
  final String? title;
  final String? hint;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?) onChanged;
  final Object? value;
  final String? prefixIconSvg;
  const MyDropDown(
      {super.key,
      this.haveTitle = true,
      this.title,
      required this.items,
      required this.onChanged,
      required this.value,
      this.havePrefix = false,
      this.prefixIconSvg,
      this.hint});

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
                  child: DropdownButton(
                    hint: Text(hint ?? 'Select Option'),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    style: appTextStyleBlack,
                    isExpanded: true,
                    value: value,
                    items: items,
                    onChanged: (value) {
                      onChanged(value);
                    },
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
