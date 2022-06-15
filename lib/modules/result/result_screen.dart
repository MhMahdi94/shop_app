import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 32.h,
                  ),
                  Image(
                    image: AssetImage('assets/images/success_order.png'),
                    height: 250.h,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'Congratulations!!',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'Your order has been successfully placed',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '----------------------------------------------------------',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Order Number: ${AppCubit.get(context).orderModel!.data!.id}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 64.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(32.sm),
                    child: defaultButton(
                      function: () {
                        navigateToWithReplacement(context, HomeLayout());
                      },
                      text: 'Ok',
                      background: mainColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
