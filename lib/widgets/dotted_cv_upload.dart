import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DottedCvUpload extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const DottedCvUpload({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: colorBlackLighter,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [4, 6],
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap ?? () {},
        child: Container(width: double.infinity, padding: const EdgeInsets.all(16), child: child),
      ),
    );
  }
}
