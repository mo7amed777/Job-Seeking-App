import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eservices/utils/image_paths.dart';

import '../utils/app_text_styles.dart';
import 'bordered_container.dart';

class CustomDropDown extends StatelessWidget {
  final bool haveTitle;
  final bool havePrefix;
  final String? title;
  final String? hint;
  final List<String> items;
  final void Function(String?) onChanged;
  final String value;
  final String? prefixIconSvg;
  const CustomDropDown(
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
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    style: appTextStyleBlack,
                    isExpanded: true,
                    value: value,
                    hint: Text(hint ?? 'Select Option'),
                    items: List.generate(
                        items.length,
                        (index) => DropdownMenuItem(
                              value: items[index],
                              child: Text(items[index]),
                            )),
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
