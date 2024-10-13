import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/widgets/my_network_image.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class FloatingCard extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String titleOne;
  final String valueOne;
  final String titleTwo;
  final String valueTwo;
  final String titleThree;
  final String valueThree;

  const FloatingCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.titleOne,
      required this.valueOne,
      required this.titleTwo,
      required this.valueTwo,
      required this.titleThree,
      required this.valueThree});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 240.h,
          //padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(flex: 3, child: Container(color: colorPrimary)),
              Expanded(flex: 2, child: Container(color: colorWhite)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 50.h),
          decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              boxShadow: [
                BoxShadow(
                    color: colorPrimaryLight,
                    offset: const Offset(0, 4),
                    blurRadius: 25),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title, style: smallTitleStyle),
              SizedBox(height: 4.h),
              Text(subTitle,
                  style: appTextStyle.copyWith(color: colorLightGreen)),
              SizedBox(height: 8.h),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorLightGrey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    columnSection(titleOne, valueOne),
                    Expanded(child: divider()),
                    columnSection(titleTwo, valueTwo),
                    Expanded(child: divider()),
                    columnSection(titleThree, valueThree),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80.h,
            width: 80.w,
            clipBehavior: Clip.antiAlias,
            //padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorWhite,
                border: Border.all(color: colorPrimaryLight)),
            child: MyImage(imageUrl: image, fit: BoxFit.fitHeight),
          ),
        ),
      ],
    );
  }

  Column columnSection(title, value) {
    return Column(
      children: [
        Text(title, style: appTextStyle),
        const SizedBox(height: 5),
        Text(value, style: appTitleStyle.copyWith(color: colorPrimary)),
      ],
    );
  }

  Widget divider() => SizedBox(
      height: 35.h, child: const VerticalDivider(color: colorLightGrey));
}
