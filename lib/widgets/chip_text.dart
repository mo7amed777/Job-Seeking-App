import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ChipText extends StatelessWidget {
  final String text;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  const ChipText({super.key, required this.text, this.color, this.textStyle, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      margin: margin,
      decoration: BoxDecoration(color: color ?? colorPrimaryLighter, borderRadius: BorderRadius.circular(30)),
      child: Text(
        text,
        style: textStyle ??
            appSubTextStyle.copyWith(color: colorPrimary, fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}
