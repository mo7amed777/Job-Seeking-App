import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? text;
  final Widget? child;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? surfaceTintColor;
  final Color? shadowColor;
  const CustomButton(
      {super.key,
      required this.onTap,
      this.text,
      this.backgroundColor,
      this.foregroundColor,
      this.height,
      this.width,
      this.surfaceTintColor,
      this.shadowColor,
      this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorPrimary,
          foregroundColor: foregroundColor ?? colorWhite,
          surfaceTintColor: surfaceTintColor,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: child ??
            Text(
              text!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
      ),
    );
  }
}
