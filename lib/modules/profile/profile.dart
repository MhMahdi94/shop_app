import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        nameController.text = cubit.userModel!.name!;
        emailController.text = cubit.userModel!.email!;
        phoneController.text = cubit.userModel!.phone!;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(8.r),
            child: Center(
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state is AppUpdateProfileLoadingState)
                        LinearProgressIndicator(),
                      Text(
                        'Edit User Data',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: mainColor,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name Must Not be Empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.account_circle,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email Must Not be Empty';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Mobile Number Must Not be Empty';
                          }
                          return null;
                        },
                        label: 'Mobile No.',
                        prefix: Icons.phone_android,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      defaultButton(
                        function: () {
                          AppCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        },
                        text: 'confirm',
                        background: mainColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
