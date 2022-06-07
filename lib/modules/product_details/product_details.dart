// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFav = false;
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        print(cubit.productDetailsModel);
        return Scaffold(
            appBar: AppBar(
                // actions: [
                //   IconButton(
                //     onPressed: () {
                //       cubit
                //           .changeFavourites(cubit.productDetailsModel!.data!.id!);
                //       cubit.getProductDetailsData(
                //           cubit.productDetailsModel!.data!.id!, context);
                //     },
                //     icon: Icon(
                //       cubit.productDetailsModel!.data!.inFavorites!
                //           ? Icons.favorite
                //           : Icons.favorite_border_outlined,
                //     ),
                //   ),
                // ],
                ),
            body: ConditionalBuilder(
              condition: cubit.productDetailsModel != null,
              builder: (context) => Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      child: CarouselSlider(
                        items: cubit.productDetailsModel!.data!.images!
                            .map(
                              (b) => Image(
                                image: NetworkImage(b),
                                width: double.infinity,
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 200.h,
                          initialPage: 0,
                          reverse: false,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(
                            seconds: 1,
                          ),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Card(
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.productDetailsModel!.data!.name!,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: mainColor,
                                  ),
                                ),
                                Divider(color: Colors.black54),
                                Text(
                                  cubit.productDetailsModel!.data!.description!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                state is AppAddToCartLoadingState
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : defaultButton(
                                        function: () {
                                          AppCubit.get(context).addToCart(cubit
                                              .productDetailsModel!.data!.id!);
                                        },
                                        text: 'Add To Cart',
                                        background: mainColor,
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ));
      },
      listener: (context, state) {
        if (state is AppAddToCartSuccessState) {
          Fluttertoast.showToast(
            msg: "Added Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: mainColor,
            textColor: Colors.white,
            fontSize: 12.0.sp,
          );
        }
        if (state is AppAddToCartFailureState) {
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
