// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/category_detail_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: state is AppGetCategoryDetailsLoadingState
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildCategoryItemDetails(
                        AppCubit.get(context)
                            .categoryDetailsModel!
                            .data!
                            .data![index],
                        context,
                      ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: AppCubit.get(context)
                      .categoryDetailsModel!
                      .data!
                      .data!
                      .length),
        );
      },
      listener: (context, state) {
        if (state is AppChangeFavouritesSuccessState ||
            state is AppAddToCartSuccessState) {
          Fluttertoast.showToast(
            msg: "Done Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: mainColor,
            textColor: Colors.white,
            fontSize: 12.0.sp,
          );
        }
      },
    );
  }

  Widget buildCategoryItemDetails(CategoryDetailProductData? model, context) {
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
                      Row(
                        children: [
                          Expanded(
                            child: defaultButton(
                              function: () {
                                AppCubit.get(context).addToCart(model.id!);
                              },
                              text: 'Add To Cart',
                              background: mainColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).changeFavourites(model.id!);
                              //print(model.id);
                            },
                            icon: Icon(
                              model.inFavorites!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: model.inFavorites!
                                  ? mainColor
                                  : Colors.black87,
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
        ),
      ),
    );
  }
}
