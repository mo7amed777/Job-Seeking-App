import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/apply_job_controller.dart';
import 'package:eservices/models/job_model.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/ui_helper.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';
import 'package:eservices/widgets/custom_button.dart';
import 'package:eservices/widgets/dotted_cv_upload.dart';
import 'package:eservices/widgets/text_back_button.dart';
import 'package:eservices/widgets/titled_input_field.dart';

import '../utils/app_text_styles.dart';

class ApplyJobScreen extends StatefulWidget {
  final Job? job;
  const ApplyJobScreen({super.key, this.job});

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TextBackButton(text: "Apply Job")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: colorPrimaryLighter,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorPrimaryLight, width: 1.3)),
              child: Column(
                children: [
                  Text(widget.job?.title ?? "Job title",
                      style: smallTitleStyle),
                  SizedBox(height: 5.h),
                  Text(widget.job?.company ?? "Company name",
                      style: appTitleStyle.copyWith(color: colorLightGreen)),
                  SizedBox(height: 5.h),
                  Text("Salary: \$${widget.job?.salary} (Monthly)",
                      style: appTextStyle),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // const TitledInputFilled(
            //     title: "Your Expected Salary (Monthly) *", hintText: "Expected Salary (Monthly)"),
            // SizedBox(height: 16.h),
            // const TitledInputFilled(
            //     title: "Your Current Salary (Monthly) *", hintText: "Current Salary (Monthly)"),
            // SizedBox(height: 16.h),
            const Text("Upload CV", style: smallTitleStyle),
            SizedBox(height: 8.h),
            GetBuilder<ApplyJobController>(builder: (controller) {
              return DottedCvUpload(
                onTap: () async {
                  await controller.pickResume();
                },
                child: controller.resume == null
                    ? Column(
                        children: [
                          SvgPicture.asset(upload),
                          SizedBox(height: 6.h),
                          const Text("Upload CV/Resume", style: appTitleStyle),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: Text(controller.resumeName ?? '')),
                          InkWell(
                              onTap: () {
                                controller.removeResume();
                              },
                              child: const Icon(Icons.cancel_outlined)),
                        ],
                      ),
              );
            }),
            SizedBox(height: 16.h),

            TitledInputFilled(
                controller: messageController,
                title: "Message",
                maxLine: 4,
                keyboardType: TextInputType.multiline),
            SizedBox(height: 30.h),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GetBuilder<ApplyJobController>(builder: (controller) {
        return Visibility(
          visible: controller.loading == false,
          replacement: const CenterProgressIndicator(),
          child: CustomButton(
            onTap: () async {
              // if (controller.resume == null) {
              //   UiHelper.showSnackBar(text: "Please upload resume first", error: true);
              // } else if (messageController.text.isEmpty) {
              //   UiHelper.showSnackBar(text: "Please enter message first", error: true);
              // } else {
              final response = await controller.applyJob(
                  jobId: widget.job?.id ?? 0,
                  message: messageController.text.trim());
              //   if (response) {
              //     showSuccessfulDialog(context);
              //   } else {
              //     UiHelper.showSnackBar(text: "Failed to apply this job", error: true);
              //   }
              // }
            },
            text: "Apply",
          ),
        );
      }),
    );
  }

  Future<dynamic> showSuccessfulDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(vertical: 25.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //SvgPicture.asset(successful),
              Image.asset(successful),
              SizedBox(height: 10.h),
              Text("Successful",
                  style: smallTitleStyle.copyWith(color: colorPrimary)),
              SizedBox(height: 5.h),
              const Text("Successfully Applied", style: appTextStyle),
              SizedBox(height: 8.h),
              CustomButton(
                //width: 140.w,
                width: MediaQuery.sizeOf(context).width / 3,
                backgroundColor: colorPrimaryLighter,
                foregroundColor: colorPrimary,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                text: "OK",
                onTap: () {
                  Get.back(closeOverlays: true);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
