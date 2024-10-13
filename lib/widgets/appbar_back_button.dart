import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/utils/image_paths.dart';

import '../utils/app_colors.dart';

class AppBarBackButton extends StatelessWidget {
  final Color? color;
  const AppBarBackButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () => Get.back(),
        //icon: Icon(Icons.arrow_back_ios_new, color: color ?? colorBlack),
        icon: SvgPicture.asset(arrowBack, color: color ?? colorBlack),
      ),
    );
  }
}
