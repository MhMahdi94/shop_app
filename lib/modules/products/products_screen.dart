// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/category_details/category_details_screen.dart';
import 'package:shop_app/modules/product_details/product_details.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.homeModel != null
              ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    productsBuilder(
                      cubit.homeModel,
                      cubit.categoryModel,
                      context,
                    ),
                    if (state is AppAddToCartLoadingState)
                      LinearProgressIndicator(),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
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

        if (state is AppChangeFavouritesFailureState) {
          Fluttertoast.showToast(
            msg: "Deleted Successfully",
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

  Widget productsBuilder(HomeModel? model, CategoryModel? catModel, context,
          {bool? isLoading = false}) =>
      Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CarouselSlider(
                items: model!.data!.banners
                    .map(
                      (b) => Image(
                        image: NetworkImage('${b.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 150.h,
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
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      height: 20.h,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildHomeCategoryItem(
                          context,
                          title: catModel!.data!.data[index].name.toString(),
                          id: catModel.data!.data[index].id,
                        ),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 4.w,
                        ),
                        itemCount: catModel!.data!.data.length,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Products',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GridView.count(
                      physics: ScrollPhysics(),
                      //physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1 / 1.6,
                      children: model.data!.products
                          .map((p) => buildProductItem(p, context))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildProductItem(ProductModel model, context) => Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                AppCubit.get(context).getProductDetailsData(model.id!, context);
                //navigateTo(context, ProductDetailsScreen());
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    padding: EdgeInsets.all(8.r),
                    child: Image(
                      image: NetworkImage(
                        model.image.toString(),
                      ),
                      height: 120.h,
                      width: double.infinity,
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      color: Colors.red,
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()} \$',
                        maxLines: 1,
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 14.sp,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            AppCubit.get(context).changeFavourites(model.id!);
                            //print(model.id);
                          },
                          icon: Icon(
                            AppCubit.get(context).favourites[model.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppCubit.get(context).favourites[model.id]!
                                ? mainColor
                                : Colors.black87,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  defaultButton(
                    function: () {
                      AppCubit.get(context).addToCart(model.id!);
                    },
                    text: 'Add To Cart',
                    background: mainColor,
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildHomeCategoryItem(BuildContext context,
          {required String title, int? id}) =>
      InkWell(
        onTap: () {
          AppCubit.get(context).getCategoryDetails(id!);
          navigateTo(context, CategoryDetailsScreen());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: mainColor,
              width: 2,
            ),
          ),
          width: 100.w,
          height: 20.h,
          child: Center(
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                color: mainColor,
                fontSize: 12.sp,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}
