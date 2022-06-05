// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: state is! AppGetFavouritesLoadingState
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return cubit.favouritesModel!.data!.data![index].product! !=
                            null
                        ? buildFavouriteItem(
                            cubit.favouritesModel!.data!.data![index].product!,
                            context,
                          )
                        : Text('sssss');
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: cubit.favouritesModel!.data!.data!.length,
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildFavouriteItem(FavouritesProduct model, context) => Container(
        padding: EdgeInsets.all(8.sp),
        height: 120.h,
        child: Row(
          children: [
            Stack(
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
                      model.image!,
                    ),
                    height: 120.h,
                    width: 120.w,
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
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.sp,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price} \$',
                          maxLines: 1,
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 16.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice}',
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
                            size: 22.r,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
