import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

final appThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: 'kumbhSans',
  colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
  appBarTheme: const AppBarTheme(titleSpacing: 0),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: colorPrimary,
          textStyle: appTextStyle.copyWith(color: colorPrimary, fontSize: 16, fontWeight: FontWeight.bold))),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.only(top: 2, left: 10),
    fillColor: colorPrimaryLight.withOpacity(0.08),
    hintStyle: const TextStyle(color: colorBlackLighter),
    constraints: BoxConstraints(maxHeight: 80.h),
    border: InputBorder.none,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: colorGreenBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: colorGreenBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: colorGreenBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: colorRed),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
