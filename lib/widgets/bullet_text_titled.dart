import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class BulletTextTitled extends StatelessWidget {
  final String title;
  final Widget child;
  const BulletTextTitled({super.key, required this.title, required this.child});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: appTitleStyle),
              child,
            ],
          ),
        )
      ],
    );
  }
}
