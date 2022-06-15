// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/orders_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/layout/home_layout.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppCancelOrderSuccessState) {
          Fluttertoast.showToast(
            msg: 'Cancelled',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: mainColor,
            textColor: Colors.white,
            fontSize: 12.0.sp,
          );
          //AppCubit.get(context).getCartData();
          //navigateToWithReplacement(context, HomeLayout());
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: cubit.ordersModel != null,
            builder: (context) => Column(
              children: [
                if (state is AppGetOrdersLoadingState)
                  LinearProgressIndicator(),
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildOrderCard(
                          cubit.ordersModel!.data!.data![index], context),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: cubit.ordersModel!.data!.data!.length),
                ),
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildOrderCard(OrdersItemData? model, context) => Padding(
        padding: EdgeInsets.all(16.sm),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: mainColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Order #${model!.id}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          AppCubit.get(context).cancelOrder(model.id);
                          //AppCubit.get(context).getOrders();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 24.r,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 16.h,
                ),
                child: Column(
                  children: [
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${model.total.round()} \$',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${model.date}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${model.status}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
