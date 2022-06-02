// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            if (state.loginModel.status!) {
              Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: mainColor,
                textColor: Colors.white,
                fontSize: 16.0.sp,
              );
              token = state.loginModel.data!.token.toString();
              CacheHelper.setData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                navigateToWithReplacement(
                  context,
                  HomeLayout(),
                );
              });
            } else {
              Fluttertoast.showToast(
                msg: state.loginModel.message!,
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
          AppLoginCubit cubit = AppLoginCubit.get(context);
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
                  top: 200.h,
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
                                      height: 8.h,
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
                                      height: 4.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        defaultTextButton(
                                            onPressed: () {},
                                            label: 'Forgot Password?'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    if (state is AppLoginLoadingState)
                                      CircularProgressIndicator(),
                                    if (state is! AppLoginLoadingState)
                                      defaultButton(
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            print('waiting for response ...');
                                            cubit.userLogin(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        text: 'Login',
                                        background: mainColor,
                                        radius: 20.r,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Don’t have any account yet?',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              defaultTextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                label: 'Register',
                              )
                            ],
                          ),
                        )
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
