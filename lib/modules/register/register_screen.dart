// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (context, state) {
          if (state is AppRegisterSuccessState) {
            if (state.registerModel.status!) {
              // token = state.registerModel.data!.token.toString();
              // CacheHelper.setData(
              //         key: 'token', value: state.registerModel.data!.token)
              //     .then(
              //   (value) {
              //     navigateToWithReplacement(
              //       context,
              //       LoginScreen(),
              //     );
              //   },
              navigateToWithReplacement(
                context,
                LoginScreen(),
              );
            } else {
              Fluttertoast.showToast(
                msg: state.registerModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: mainColor,
                textColor: Colors.red,
                fontSize: 10.0.sp,
              );
            }
          }
        },
        builder: (context, state) {
          AppRegisterCubit cubit = AppRegisterCubit.get(context);
          return Scaffold(
            //appBar: AppBar(),
            body: Stack(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Positioned(
                  top: -75.h,
                  left: -60.w,
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 160.h,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Image(
                          image: AssetImage('assets/images/onBoard1.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    //User name
                                    defaultFormField(
                                      controller: nameController,
                                      type: TextInputType.name,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'UserName is required';
                                        }
                                        return null;
                                      },
                                      label: 'User name',
                                      prefix: Icons.person_outline,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    //Email
                                    defaultFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Email Address is required';
                                        }
                                        return null;
                                      },
                                      label: 'Email Address',
                                      prefix: Icons.email_outlined,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    //Phone No
                                    defaultFormField(
                                      controller: phoneController,
                                      type: TextInputType.phone,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Phone No. is required';
                                        }
                                        return null;
                                      },
                                      label: 'Phone No.',
                                      prefix: Icons.phone_android_outlined,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    //Password
                                    defaultFormField(
                                      controller: passwordController,
                                      isPassword: true,
                                      type: TextInputType.visiblePassword,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Password is required';
                                        }
                                        return null;
                                      },
                                      label: 'Password',
                                      prefix: Icons.lock_outline,
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),

                                    if (state is AppRegisterLoadingState)
                                      const CircularProgressIndicator(),
                                    if (state is! AppRegisterLoadingState)
                                      defaultButton(
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            print('waiting for response ...');
                                            cubit.userRegister(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              phone: phoneController.text,
                                            );
                                          }
                                        },
                                        text: 'Register',
                                        background: mainColor,
                                        radius: 20.r,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
