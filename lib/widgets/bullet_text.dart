import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class BulletText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const BulletText({super.key, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 10, top: 10),
          child: CircleAvatar(radius: 2.r, backgroundColor: colorBlack),
        ),
        Flexible(
          child: Text(text, style: textStyle ?? appTextStyle),
        )
      ],
    );
  }
}
