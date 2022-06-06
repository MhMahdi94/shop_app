// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onBoarding/onboarding_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/bloc_observer.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/theme.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();

      //isDark = CacheHelper.getBoolean(key: 'isDark')!;
      var onBoarding = CacheHelper.getData(key: 'onBoard');
      // print(onBoarding);
      token = CacheHelper.getData(key: 'token') ?? null;
      print('token: $token');
      Widget startWidget;

      if (onBoarding != null) {
        if (token != null) {
          startWidget = HomeLayout();
        } else {
          startWidget = LoginScreen();
        }
      } else {
        startWidget = OnBoardingScreen();
      }
      runApp(MyApp(
        startWidget: startWidget,
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData()
            ..getCartData(),
          child: BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                home: child,
              );
            },
          ),
        );
      },
      child: startWidget,
      // child: Directionality(
      //   textDirection: TextDirection.rtl,
      //   child: HomeLayout(),
      // ),
    );
  }
}
