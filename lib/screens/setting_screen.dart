import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/app_text_controller.dart';
import 'package:eservices/controllers/language_controller.dart';
import 'package:eservices/controllers/local_text_controller.dart';
import 'package:eservices/models/app_text_model.dart';
import 'package:eservices/models/languages_model.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/widgets/text_back_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notification = true;
  bool darkMode = true;
  static List<Language> appLanguages =
      Get.find<LanguageController>().languages?.reversed.toList() ?? [];
  Language selectedLanguage = appLanguages.first;

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextBackButton(text: terms?.setting ?? "Setting")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            settingOption(
              icon: appliedJobsIcon,
              text: terms?.language ?? "",
              trailing: GetBuilder<AppTextController>(builder: (controller) {
                if (controller.loading) {
                  return const CupertinoActivityIndicator(color: colorPrimary);
                }
                return DropdownButtonHideUnderline(
                  child: DropdownButton<Language>(
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    style: appTextStyleBlack,
                    value: selectedLanguage,
                    onChanged: (Language? value) async {
                      selectedLanguage = value!;
                      final res =
                          await controller.getAppTexts(selectedLanguage.code);
                      setState(() {});
                    },
                    items: List.generate(
                      appLanguages.length,
                      (index) => DropdownMenuItem(
                        value: appLanguages[index],
                        child: Text(appLanguages[index].name ?? ''),
                      ),
                    ),
                  ),
                );
              }),
              // trailing: DropdownButtonHideUnderline(
              //   child: DropdownButton(
              //     icon: const Icon(Icons.keyboard_arrow_down_sharp),
              //     style: appTextStyleBlack,
              //     value: language,
              //     items: List.generate(
              //       languages.length,
              //       (index) => DropdownMenuItem(
              //         value: languages[index],
              //         child: Text(languages[index]),
              //       ),
              //     ),
              //     onChanged: (String? value) {
              //       language = value!;
              //       setState(() {});
              //     },
              //   ),
              // ),
            ),
            settingOption(
              icon: bell,
              text: terms?.notification ?? "Notification",
              trailing: Switch(
                value: notification,
                onChanged: (value) {
                  notification = value;
                  setState(() {});
                },
              ),
            ),
            // settingOption(
            //   icon: moon,
            //   text: "Dark Mode",
            //   trailing: Switch(
            //     value: darkMode,
            //     onChanged: (value) {
            //       darkMode = value;
            //       setState(() {});
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Column settingOption({required icon, required text, required trailing}) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 8.w),
            Text(text, style: appTitleStyle),
            const Spacer(),
            SizedBox(height: 30.h, child: FittedBox(child: trailing)),
          ],
        ),
        const Divider(color: colorBlackLighter, thickness: 0.4),
      ],
    );
  }
}
