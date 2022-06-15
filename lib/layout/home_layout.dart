// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/carts/carts_screen.dart';
import 'package:shop_app/modules/orders/orders_screen.dart';
import 'package:shop_app/modules/profile/profile.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:loading_overlay/loading_overlay.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          drawer: Drawer(
            backgroundColor: mainColor,
            child: Center(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: mainColor),
                    accountName: Text(
                      'Mohammed Mahdy',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    accountEmail: Text(
                      "mohdmahdy94@gmail.com",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    currentAccountPictureSize: Size.square(65.sm),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "M",
                        style: TextStyle(fontSize: 30.0, color: mainColor),
                      ), //Text
                    ), //circleAvatar
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),

                  //
                  ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 32.sm,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      //Navigator.pop(context);
                      navigateToWithReplacement(context, HomeLayout());
                    },
                  ),
                  //
                  ListTile(
                    leading: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 32.sm,
                    ),
                    title: Text(
                      'My Orders',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      //Navigator.pop(context);
                      cubit.getOrders();
                      navigateTo(context, OrdersScreen());
                    },
                  ),
                  //
                  ListTile(
                    leading: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 32.sm,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      navigateTo(context, ProfileScreen());
                    },
                  ),
                  Spacer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        IconButton(
                          onPressed: () {
                            signOut(context);
                          },
                          icon: Icon(
                            Icons.logout_outlined,
                            size: 52.sm,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'LogOut',
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                        //cubit.getCartData();
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
                        '${cubit.cartCount}', //.toString(),
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
