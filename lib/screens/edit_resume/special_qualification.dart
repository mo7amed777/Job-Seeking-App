import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/widgets/bordered_container.dart';
import 'package:eservices/widgets/chip_text.dart';

class SpecialQualification extends StatefulWidget {
  const SpecialQualification({super.key});

  @override
  State<SpecialQualification> createState() => _SpecialQualificationState();
}

class _SpecialQualificationState extends State<SpecialQualification> {
  List<String> items = [
    'Ui/Ux Designer',
    'Graphics Designer',
    'Microsoft Office',
    'Figma',
  ];
  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        // TitledInputFilled(
        //     title: "Special Qualification",
        //     //hintText: "Say something",
        //     maxLine: 8,
        //     keyboardType: TextInputType.multiline
        //     //maxHeight: 170.h,
        //     ),
        const Text("Special Qualification", style: appTitleStyle),
        SizedBox(height: 8.h),
        BorderedContainer(
          child: Wrap(
            spacing: 5.w,
            runSpacing: 5.h,
            children: items.map((e) {
              bool selected = selectedItems.contains(e);
              return InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    if (selected) {
                      selectedItems.remove(e);
                    } else {
                      selectedItems.add(e);
                    }
                    setState(() {});
                  },
                  child: ChipText(
                      text: e,
                      color: selected ? colorPrimaryLighter : colorLightGrey,
                      textStyle: appTextStyle.copyWith(
                          fontSize: 14,
                          color: selected ? colorPrimary : colorBlack)));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
