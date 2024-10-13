import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class TitledInputFilled extends StatelessWidget {
  final bool? enabled;
  final String title;
  final String? hintText;
  final int? maxLine;
  final double? maxHeight;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  const TitledInputFilled(
      {super.key,
      required this.title,
      this.hintText,
      this.controller,
      this.maxLine,
      this.maxHeight,
      this.keyboardType,
      this.contentPadding,
      this.suffixIcon,
      this.validator,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: smallTitleStyle),
        SizedBox(height: 8.h),
        TextFormField(
          enabled: enabled ?? true,
          onTapOutside: (f) {
            //SystemChannels.textInput.invokeMethod('TextInput.hide');
            //FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          validator: validator,
          maxLines: maxLine ?? 1,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              filled: false,
              constraints: BoxConstraints(maxHeight: maxHeight ?? 100.h),
              contentPadding: contentPadding ?? const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: colorLightGrey)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: colorRed)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: colorLightGrey)),
              hintText: hintText,
              suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
