// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/profile/profile.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Column(
            // ignore: prefer_const_literals_to_create_immutables

            children: [
              Spacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                child: Card(
                  elevation: 5,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  cubit.userModel!.image!,
                                ),
                                radius: 50.r,
                                child: Container(
                                  width: 120.w,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: mainColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                cubit.userModel!.name!,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                cubit.userModel!.email!,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.r),
                        child: IconButton(
                          onPressed: () {
                            navigateTo(context, ProfileScreen());
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: mainColor,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(16.sp),
                child: defaultButton(
                  function: () {
                    signOut(context);
                  },
                  text: 'Logout',
                  background: mainColor,
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}
