// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/carts/carts_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Shop App'),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search_outlined,
                  size: 22.sp,
                  color: Colors.black45,
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context, CartsScreen());
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        size: 22.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Container(
                    width: 15.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        cubit.cartModel == null
                            ? '0'
                            : cubit.cartModel!.data!.cartItems!.length
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeBottomTabIndex(value);
            },
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
