// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/modules/result/result_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/layout/home_layout.dart';

class OrderScreen extends StatelessWidget {
  //const OrderScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var cardNumberController = TextEditingController();
  var cardExpiryDateController = TextEditingController();
  var cardPinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppAddOrderSuccessState) {
          if (state.orderModel!.status!) {
            Fluttertoast.showToast(
              msg: state.orderModel!.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: mainColor,
              textColor: Colors.white,
              fontSize: 12.0.sp,
            );
            AppCubit.get(context).getCartData();
            navigateToWithReplacement(context, ResultScreen());
          } else {
            Fluttertoast.showToast(
              msg: state.orderModel!.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: mainColor,
              textColor: Colors.red,
              fontSize: 12.0.sp,
            );
          }
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.sm),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Column(
                        children: [
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Delivered To',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${cubit.addressModel!.data!.name!}-${cubit.addressModel!.data!.city!}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: mainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Text(
                                    '${cubit.cartModel!.data!.total} \$',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                              Spacer(),
                              DropdownButton(
                                hint: Text('Select Method'),
                                value: cubit.paymentMethod,
                                // ignore: prefer_const_literals_to_create_immutables
                                items: [
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text('Cash on Delivery'),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('Card Payment'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('Paypal'),
                                  ),
                                ],
                                onChanged: (dynamic value) {
                                  cubit.selectPaymentMethod(value);
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          if (cubit.paymentMethod == 1)
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  defaultFormField(
                                    controller: cardNumberController,
                                    type: TextInputType.number,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Card Number is Required';
                                      }
                                      return null;
                                    },
                                    label: 'Card Number',
                                    prefix: Icons.payment_outlined,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  defaultFormField(
                                    controller: cardExpiryDateController,
                                    type: TextInputType.number,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Card Expiry Date is Required';
                                      }
                                      return null;
                                    },
                                    label: 'Expiry Date',
                                    prefix: Icons.date_range_outlined,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  defaultFormField(
                                    controller: cardPinController,
                                    type: TextInputType.number,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'PIN is Required';
                                      }
                                      return null;
                                    },
                                    label: 'PIN',
                                    prefix: Icons.pin,
                                    isPassword: true,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.sm),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8.h),
                        Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        Divider(
                          color: mainColor,
                          thickness: 2,
                          indent: 20.sm,
                          endIndent: 20.sm,
                        ),
                        Container(
                          height: 350.h,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildOrderCartItem(
                                cubit
                                    .cartModel!.data!.cartItems![index].product,
                                context,
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: cubit.cartModel!.data!.cartItems!.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.sm,
                  ),
                  child: state is AppAddOrderLoadingState
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : defaultButton(
                          function: () {
                            // print(cubit.paymentMethod);
                            // print(cubit.addressModel!.data!.id);
                            if (cubit.paymentMethod == 1) {
                              if (formKey.currentState!.validate()) {
                                cubit.postOrder(
                                  address_id: cubit.addressModel!.data!.id!,
                                  payment_method: cubit.paymentMethod,
                                );
                              }
                            } else {
                              cubit.postOrder(
                                address_id: cubit.addressModel!.data!.id!,
                                payment_method: cubit.paymentMethod,
                              );
                            }
                          },
                          text: 'confirm',
                          background: mainColor,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOrderCartItem(CartProduct? model, context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: InkWell(
        onTap: () {
          AppCubit.get(context).getProductDetailsData(model!.id!, context);
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.all(4.r),
                  child: Image(
                    image: NetworkImage(model!.image!),
                    width: 80.w,
                    height: 80.h,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Text(
                            model.price!.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            model.oldPrice!.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
