import 'package:flutter/material.dart';
import 'package:job_nect/utils/app_colors.dart';

class VerticalDivider extends StatelessWidget {
  final double? thickness;
  final double? height;
  final Color? color;
  const VerticalDivider({super.key, this.thickness, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? colorLightGrey,
      height: height ?? 10,
      width: thickness ?? 5,
    );
  }
}
