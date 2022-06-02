// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/models/on_boarding_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: 'assets/images/onBoard1.png',
      title: 'OnBoarding Title 1',
      subtitle: 'OnBoarding subtitle 1',
    ),
    OnBoardingModel(
      image: 'assets/images/onBoard1.png',
      title: 'OnBoarding Title 2',
      subtitle: 'OnBoarding subtitle 2',
    ),
    OnBoardingModel(
      image: 'assets/images/onBoard1.png',
      title: 'OnBoarding Title 3',
      subtitle: 'OnBoarding subtitle 3',
    ),
  ];

  PageController onBoardingController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: isLast
            ? null
            : [
                TextButton(
                  onPressed: submit,
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: onBoardingController,
              itemBuilder: (context, index) {
                return buildOnBoardItem(boarding[index]);
              },
              itemCount: boarding.length,
              physics: BouncingScrollPhysics(),
              onPageChanged: (value) {
                if (value == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: mainColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.h,
                    dotWidth: 10.w,
                    // strokeWidth: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      onBoardingController.nextPage(
                        duration: Duration(
                          microseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void submit() {
    CacheHelper.setData(
      key: 'onBoard',
      value: true,
    ).then((value) {
      if (value) {
        navigateToWithReplacement(
          context,
          LoginScreen(),
        );
      }
    });
  }

  Widget buildOnBoardItem(OnBoardingModel model) {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage(model.image),
                height: 200.h,
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            model.subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
