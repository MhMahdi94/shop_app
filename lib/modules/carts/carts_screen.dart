// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        //print(cubit.cartModel!.data!.cartItems![0]);
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (state is AppGetCartDataLoadingState)
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
          body: //state is AppGetCartDataLoadingState
              // ignore: prefer_const_constructors
              //? Center(child: CircularProgressIndicator())
              //:
              ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.r),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                            ),
                          ),
                          child: Image(
                            image: NetworkImage(
                              cubit.cartModel!.data!.cartItems![index].product!
                                  .image!,
                            ),
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
                                cubit.cartModel!.data!.cartItems![index]
                                    .product!.name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    cubit.cartModel!.data!.cartItems![index]
                                        .product!.price!
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  if (cubit.cartModel!.data!.cartItems![index]
                                          .product!.discount !=
                                      null)
                                    Text(
                                      cubit.cartModel!.data!.cartItems![index]
                                          .product!.oldPrice!
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: mainColor,
                                    ),
                                    width: 20.w,
                                    height: 20.h,
                                    child: Center(
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          cubit.decrementQuantity();
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: Text(
                                      '${cubit.cartQuantity}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: mainColor,
                                    ),
                                    width: 20.w,
                                    height: 20.h,
                                    child: Center(
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          cubit.incrementQuantity();
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: defaultTextButton(
                                      onPressed: () {
                                        cubit.deleteFromCart(cubit.cartModel!
                                            .data!.cartItems![index].id!);
                                      },
                                      label: 'DELETE',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: cubit.cartModel!.data!.cartItems!.length,
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.shopping_cart),
            label: Text(
              'Order Now',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {},
          ),
        );
      },
      listener: (context, state) {
        if (state is AppDeleteCartDataSuccessState) {
          Fluttertoast.showToast(
            msg: "Deleted Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: mainColor,
            textColor: Colors.white,
            fontSize: 12.0.sp,
          );
        }
        if (state is AppDeleteCartDataFailureState) {
          Fluttertoast.showToast(
            msg: "Error Occured",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: mainColor,
            textColor: Colors.red,
            fontSize: 12.0.sp,
          );
        }
      },
    );
  }
}
