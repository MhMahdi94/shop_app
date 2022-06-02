import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSearchCubit(),
      child: BlocConsumer<AppSearchCubit, AppSearchStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.all(16.r),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                      controller: textController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Search Field mudt not be empty';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onSubmit: (String value) {
                        AppSearchCubit.get(context).productSearch(text: value);
                      },
                    ),
                    if (state is AppSearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 8.h,
                    ),
                    if (AppSearchCubit.get(context).searchModel != null)
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: GridView.count(
                            physics: ScrollPhysics(),
                            //physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 1 / 1.57,
                            children: AppSearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .map((p) => buildSearchProductItem(p, context))
                                .toList(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget buildSearchProductItem(SearchProductData model, context) => Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          //AppCubit.get(context).changeFavourites(model.id!);
                          //print(model.id);
                        },
                        icon: Icon(
                            //AppCubit.get(context).favourites[model.id]!
                            //  ? Icons.favorite
                            Icons.favorite_border,
                            color: // AppCubit.get(context).favourites[model.id]!
                                mainColor
                            //: Colors.black87,
                            ),
                      ),
                    ],
                  ),
                  defaultButton(
                    function: () {},
                    text: 'Add To Cart',
                    background: mainColor,
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
