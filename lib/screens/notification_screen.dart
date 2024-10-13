import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart'; // Ensure Get package is imported
import 'package:job_nect/controllers/notification_controller.dart';
import 'package:job_nect/utils/app_colors.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/widgets/text_back_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  @override
  void initState() {
    super.initState();
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.find<NotificationController>().getNotification();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const TextBackButton(text: "Notification"),
       
      ),
      body: GetBuilder<NotificationController>(builder: (controller) {
        // Assuming controller.notifications[index] contains your data

        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        var notifications = controller.notifications ?? [];

        // Check if notifications list is empty
        if (notifications.isEmpty) {
          return const Center(
            child: Text("No notifications available.", style: appTitleStyle),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: notifications
              .length, // Update this with actual notification count
          itemBuilder: (context, index) {
            var notification = notifications[index];

            return Container(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: index == 0 ? colorPrimaryLighter : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundImage: const AssetImage(
                        figma), // Replace with actual image if needed
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title ??
                              "No title", // Replace with actual title
                          style: appTitleStyle,
                          maxLines: 2,
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          notification.description ??
                              "No description", // Replace with actual description
                          style: appSubTextStyle,
                          maxLines: 3,
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          notification.date ??
                              'No date', // Replace with actual date
                          style: appTitleStyle.copyWith(
                            fontSize: 13,
                            color: colorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PopupMenuButton(
                  //   itemBuilder: (context) {
                  //     return [
                  //       PopupMenuItem(
                  //         child: Text(
                  //           "Delete",
                  //           style: appTextStyle.copyWith(color: colorRed),
                  //         ),
                  //         onTap: () {
                  //           // Add your delete functionality here
                  //         },
                  //       ),
                  //     ];
                  //   },
                  //   padding: EdgeInsets.zero,
                  //   icon: const Icon(Icons.more_horiz),
                  // ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
