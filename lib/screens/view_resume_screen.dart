import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/auth_controller.dart';
import 'package:eservices/controllers/education_levels_controller.dart';
import 'package:eservices/controllers/job_levels_controller.dart';
import 'package:eservices/controllers/job_types_controller.dart';
import 'package:eservices/controllers/resume_details_controller.dart';
import 'package:eservices/models/resume_model.dart';
import 'package:eservices/models/user.dart';
import 'package:eservices/screens/edit_resume/edit_resume_screen.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/widgets/bordered_container.dart';
import 'package:eservices/widgets/bullet_text_titled.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';
import 'package:eservices/widgets/text_back_button.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';
import '../widgets/bullet_text.dart';

class ViewResumeScreen extends StatefulWidget {
  const ViewResumeScreen({super.key});

  @override
  State<ViewResumeScreen> createState() => _ViewResumeScreenState();
}

class _ViewResumeScreenState extends State<ViewResumeScreen> {
  Terms? terms = LocalTextController.terms;
  @override
  void initState() {
    super.initState();
    if (Get.find<ResumeDetailsController>().resume == null) {
      Get.find<ResumeDetailsController>().getResumeDetails();
    }
    if (Get.find<JobTypesController>().jobTypes == null) {
      Get.find<JobTypesController>().getJobTypes();
    }
    if (Get.find<JobLevelsController>().jobLevels == null) {
      Get.find<JobLevelsController>().getJobLevels();
    }
    if (Get.find<EducationLevelsController>().educationLevels == null) {
      Get.find<EducationLevelsController>().getEducationLevels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GetBuilder<ResumeDetailsController>(builder: (controller) {
        Resume? resume = controller.resume;
        User? user = Get.find<AuthController>().user;
        if (controller.loading) {
          return const CenterProgressIndicator();
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              contactDetails(resume),
              SizedBox(height: 8.h),
              careerObjective(resume),
              SizedBox(height: 8.h),
              personalDetails(resume),
              SizedBox(height: 8.h),
              // specialQualification(resume),
              // SizedBox(height: 8.h),
              workExperience(resume),
              SizedBox(height: 8.h),
              academicQualification(resume),
              SizedBox(height: 8.h),
              trainingSection(resume),
              SizedBox(height: 8.h),
              languageSection(resume),
              SizedBox(height: 8.h),
              referenceSection(resume),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TextBackButton(text: terms?.viewResume ?? "View Resume"),
      actions: [
        IconButton(
          onPressed: () => Get.to(const EditResumeScreen()),
          icon: SvgPicture.asset(edit, height: 18.h),
        )
      ],
    );
  }

  BorderedContainer contactDetails(Resume? resume) {
    //var user = resume?;
    //User? user = Get.find<AuthController>().user;
    return BorderedContainer(
      child: Column(
        children: [
          SizedBox(
              height: 100.h,
              width: 100.w,
              child:
                  Image.network(resume?.profilePhoto ?? '', fit: BoxFit.cover)),
          SizedBox(height: 8.h),
          Text(resume?.name ?? "Applicant Name",
              style: mediumTitleStyle.copyWith(fontSize: 20)),
          SizedBox(height: 8.h),
          Text(resume?.email ?? "Applicant Email", style: appTextStyleBlack),
          Text("${terms?.phone ?? "Phone"}: ${resume?.phone}",
              style: appTextStyleBlack),
          //Text("Address: ${user?.}", style: appTextStyleBlack, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  BorderedContainer careerObjective(Resume? resume) {
    return BorderedContainer(
      title: terms?.careerObjective ?? "Career Objective",
      body: Text(resume?.careerObjective ?? "Career Description",
          style: appTextStyleBlack),
    );
  }

  BorderedContainer specialQualification(Resume? resume) {
    return BorderedContainer(
      title: "Special Qualification",
      body: Column(
          // children: [
          //   BulletText(text: "Ui/Ux Designer", textStyle: appTextStyleBlack),
          //   BulletText(text: "Graphics Designer", textStyle: appTextStyleBlack),
          //   BulletText(text: "Microsoft Office", textStyle: appTextStyleBlack),
          //   BulletText(text: "Figma", textStyle: appTextStyleBlack),
          // ],
          children: List.generate(
              resume?.skills?.length ?? 0,
              (index) => BulletText(
                  text: resume?.skills?[index] ?? 'skill',
                  textStyle: appTextStyleBlack))),
    );
  }

  BorderedContainer personalDetails(Resume? resume) {
    var info = resume;
    return BorderedContainer(
      title: terms?.personalDetails ?? "Personal Details",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // colonText(key: "Name", value: info?.name ?? "Desio Talukder"),
          colonText(
              key: terms?.fathersName ?? "Father's Name",
              value: info?.fatherName ?? ''),
          colonText(
              key: terms?.mothersName ?? "Mother's Name",
              value: info?.motherName ?? ''),
          colonText(
              key: terms?.dateOfBirth ?? "Date of Birth",
              value: info?.dateOfBirth ?? ''),
          colonText(key: terms?.gender ?? "Gender", value: info?.gender ?? ''),
          colonText(
              key: terms?.maritalStatus ?? "Marital Status",
              value: info?.maritalStatus ?? ''),
          colonText(
              key: terms?.nationality ?? "Nationality",
              value: info?.nationality ?? ''),
          // colonText(key: "Religion", value: info?.fatherName ?? "Islam"),
          colonText(
              key: terms?.presentAddress ?? "Present Address",
              value: info?.presentAddress ?? ''),
          colonText(
              key: terms?.permanentAddress ?? "Permanent Address",
              value: info?.permanentAddress ?? ''),
        ],
      ),
    );
  }

  BorderedContainer workExperience(Resume? resume) {
    return BorderedContainer(
      title: terms?.workExperience ?? "Work Experience",
      body: Column(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: resume?.experiences?.length ?? 0,
            itemBuilder: (context, index) {
              var exp = resume?.experiences?[index];
              return BulletTextTitled(
                title: resume?.experiences?[index].business ?? "Company",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${terms?.designation ?? "Designation"}: ${exp?.designation} (${exp?.startDate} - ${exp?.startDate})",
                        style: appTextStyleBlack),
                    Text("${terms?.address ?? "Address"}: ${exp?.location}",
                        style: appTextStyleBlack),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  BorderedContainer academicQualification(Resume? resume) {
    return BorderedContainer(
      title: terms?.academicQualification ?? "Academic Qualification",
      body: Column(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: resume?.educations?.length ?? 0,
            itemBuilder: (context, index) {
              var education = resume?.educations?[index];
              return BulletTextTitled(
                title: education?.level ?? "",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${terms?.institute ?? "Institute"}: ${education?.institute}",
                        style: appTextStyleBlack),
                    Text("${terms?.major ?? "Major"}: ${education?.major}",
                        style: appTextStyleBlack),
                    Text("${terms?.exam ?? "Exam"}: ${education?.exam}",
                        style: appTextStyleBlack),
                    Text("${terms?.result ?? "Result"}: ${education?.result}",
                        style: appTextStyleBlack),
                    Text(
                        "${terms?.passingYear ?? "Passing Year"}: ${education?.endDate}",
                        style: appTextStyleBlack),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  BorderedContainer trainingSection(Resume? resume) {
    return BorderedContainer(
      title: terms?.trainingSummary ?? "Training Summary",
      body: Column(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: resume?.trainings?.length ?? 0,
            itemBuilder: (context, index) {
              final training = resume?.trainings?[index];
              return BulletTextTitled(
                title: training?.name ?? "",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Institute: ${training?.institute}",
                        style: appTextStyleBlack),
                    Text("Topics: ${training?.topics}",
                        style: appTextStyleBlack),
                    Text("Location: ${training?.location}",
                        style: appTextStyleBlack),
                    Text(
                        "Duration: ${training?.startDate} - ${training?.endDate}",
                        style: appTextStyleBlack),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  BorderedContainer languageSection(Resume? resume) {
    return BorderedContainer(
      title: terms?.language ?? "Language",
      body: Column(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: resume?.resumeLanguages?.length ?? 0,
            itemBuilder: (context, index) {
              final lang = resume?.resumeLanguages?[index];
              return BulletTextTitled(
                title: lang?.name ?? "",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Reading: ${lang?.reading}", style: appTextStyleBlack),
                    Text("Writing: ${lang?.writing}", style: appTextStyleBlack),
                    Text("Speaking: ${lang?.speaking}",
                        style: appTextStyleBlack),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    // Table(
    //   border: TableBorder.all(color: colorLightGrey, width: 1.5),
    //   children: [
    //     TableRow(
    //       children: [
    //         tableTitle("Language"),
    //         tableTitle("Reading"),
    //         tableTitle("Writing"),
    //         tableTitle("Speaking"),
    //       ],
    //     ),
    //     TableRow(
    //       children: [
    //         tableText("Bengali"),
    //         tableText("High"),
    //         tableText("High"),
    //         tableText("High"),
    //       ],
    //     ),
    //     TableRow(
    //       children: [
    //         tableText("English"),
    //         tableText("Medium"),
    //         tableText("Slow"),
    //         tableText("Week"),
    //       ],
    //     ),
    //   ],
    // ),
  }

  BorderedContainer referenceSection(Resume? resume) {
    return BorderedContainer(
      title: terms?.reference ?? "Reference",
      body: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: resume?.references?.length ?? 0,
        itemBuilder: (context, index) {
          final reference = resume?.references?[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              colonText(
                  key: terms?.name ?? "Name", value: reference?.name ?? ""),
              colonText(
                  key: terms?.organization ?? "Organization",
                  value: reference?.organization ?? ""),
              colonText(
                  key: terms?.designation ?? "Designation",
                  value: reference?.designation ?? ""),
              colonText(
                  key: terms?.address ?? "Address",
                  value: reference?.address ?? ""),
              colonText(
                  key: terms?.phone ?? "Phone", value: reference?.phone ?? ""),
              colonText(
                  key: terms?.email ?? "Email", value: reference?.email ?? ""),
              colonText(
                  key: terms?.relation ?? "Relation",
                  value: reference?.relation ?? ""),
            ],
          );
        },
      ),
    );
  }

  Widget colonText({required key, required value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(key, style: appTextStyleBlack)),
        Text(" :  ",
            style: appTextStyleBlack.copyWith(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value, style: appTextStyleBlack)),
      ],
    );
  }

  Padding tableText(text) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Text(text, style: appTextStyleBlack),
    );
  }

  Padding tableTitle(text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(text,
          style: appTextStyleBlack.copyWith(
              fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }
}
