// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/modules/category_details/category_details_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              //physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1 / 1,
              children: AppCubit.get(context)
                  .categoryModel!
                  .data!
                  .data
                  .map((p) => buildCategoryItem(p, context))
                  .toList(),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildCategoryItem(DataModel? model, context) => InkWell(
        onTap: () {
          AppCubit.get(context).getCategoryDetails(model!.id!);
          navigateTo(context, CategoryDetailsScreen());
        },
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Image(
                image: NetworkImage(
                  model!.image.toString(),
                ),
                width: 100.w,
                height: 100.h,
              ),
              Spacer(),
              Container(
                width: double.infinity,
                color: Colors.black26,
                padding: EdgeInsets.all(6.r),
                child: Center(
                  child: Text(
                    model.name.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
