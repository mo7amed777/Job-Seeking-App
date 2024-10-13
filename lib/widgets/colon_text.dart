import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class ColonText extends StatelessWidget {
  final String keyText;
  final String valueText;
  const ColonText({super.key, required this.keyText, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(keyText, style: appTextStyleBlack)),
        Text(" :  ", style: appTextStyleBlack.copyWith(fontWeight: FontWeight.bold)),
        Expanded(child: Text(valueText, style: appTextStyleBlack)),
      ],
    );
    ;
  }
}
