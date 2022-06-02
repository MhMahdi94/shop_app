// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/colors.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: mainColor),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: backgroundColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: mainColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: mainColor,
      size: 20.sp,
    ),
  ),
  scaffoldBackgroundColor: backgroundColor,
  fontFamily: 'Abel',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.black45,
    elevation: 10,
    selectedIconTheme: IconThemeData(size: 20.sp),
    selectedLabelStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
    ),
  ),
);
ThemeData darkTheme = ThemeData();
