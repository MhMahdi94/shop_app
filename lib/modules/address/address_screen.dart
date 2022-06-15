// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/get_adressess_model.dart';
import 'package:shop_app/modules/order/order_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class AddressFormScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  var notesController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();
  bool isForm = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(24.sm),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(24.sm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Address Form',
                              style: TextStyle(
                                fontSize: 24.sp,
                              ),
                            ),
                            Spacer(),
                            AppCubit.get(context).isForm
                                ? defaultTextButton(
                                    onPressed: () {
                                      AppCubit.get(context).getAddresses();
                                    },
                                    label: 'History',
                                  )
                                : defaultTextButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeIsForm(true);
                                    },
                                    label: 'Back',
                                  ),
                          ],
                        ),
                        state is AppGetAddressesLoadingState
                            ? LinearProgressIndicator()
                            : Divider(
                                color: mainColor,
                                height: 16.h,
                                thickness: 1,
                              ),
                        SizedBox(
                          height: 8.h,
                        ),
                        AppCubit.get(context).isForm
                            ? buildAddressForm()
                            : Container(
                                height: 300.h,
                                child: buildAddressHistoryList(
                                  AppCubit.get(context)
                                      .getAddressesModel!
                                      .data!,
                                ),
                              ),
                        SizedBox(
                          height: 32.h,
                        ),
                        if (state is AppCreateAddressLoadingState)
                          Center(child: CircularProgressIndicator())
                        else if (AppCubit.get(context).isForm)
                          defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).postAddress(
                                    name: nameController.text,
                                    city: cityController.text,
                                    region: regionController.text,
                                    details: detailsController.text,
                                    notes: notesController.text,
                                    latitude: latitudeController.text,
                                    longitude: longitudeController.text);
                              }
                            },
                            text: 'confirm',
                            background: mainColor,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AppCreateAddressSuccessState) {
          Fluttertoast.showToast(
            msg: AppCubit.get(context).addressModel!.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: mainColor,
            textColor: Colors.white,
            fontSize: 12.0.sp,
          );
          navigateTo(context, OrderScreen());
        }
        if (state is AppGetAddressesSuccessState) {
          AppCubit.get(context).changeIsForm(false);
        }
        // else {
        //   isForm = true;
        // }
      },
    );
  }

  Widget buildAddressForm() => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //name
            defaultFormField(
              controller: nameController,
              type: TextInputType.name,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              label: 'Name',
              prefix: Icons.person,
            ),
            SizedBox(
              height: 8.h,
            ),
            //city
            Row(
              children: [
                Expanded(
                  child: defaultFormField(
                    controller: cityController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'City is required';
                      }
                      return null;
                    },
                    label: 'City',
                    prefix: Icons.location_pin,
                  ),
                ),
                //region
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: defaultFormField(
                    controller: regionController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Region is required';
                      }
                      return null;
                    },
                    label: 'Region',
                    prefix: Icons.location_pin,
                  ),
                ),
              ],
            ),

            //details
            SizedBox(
              height: 8.h,
            ),
            defaultFormField(
              controller: detailsController,
              type: TextInputType.name,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Details is required';
                }
                return null;
              },
              label: 'Details',
              prefix: Icons.info,
            ),

            //notes
            SizedBox(
              height: 8.h,
            ),
            defaultFormField(
              controller: notesController,
              type: TextInputType.name,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Notes is required';
                }
                return null;
              },
              label: 'Notes',
              prefix: Icons.notes,
            ),

            //latitute
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                  child: defaultFormField(
                    controller: latitudeController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Latitude is required';
                      }
                      return null;
                    },
                    label: 'Latitude',
                    prefix: Icons.location_searching,
                  ),
                ),
                //longitude
                SizedBox(
                  width: 8.w,
                ),

                Expanded(
                  child: defaultFormField(
                    controller: longitudeController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Longitude is required';
                      }
                      return null;
                    },
                    label: 'Longitude',
                    prefix: Icons.location_searching,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildAddressHistoryList(
    AddressesData? model,
  ) =>
      ListView.separated(
        itemBuilder: (context, index) {
          /*{id: 1807, name: Omdurman, city: Abu saed, region: block1, details: sea street, notes: aaa, latitude: 20,
       longitude: 75}*/
          return ListTile(
            title: Stack(
              children: [
                Text(
                  model!.data![index].name!,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.sp,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: defaultTextButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .deleteAddress(model.data![index].id);
                      },
                      label: 'Remove'),
                ),
              ],
            ),
            subtitle: Text(
              '${model.data![index].city!} - ${model.data![index].region!}',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12.sp,
              ),
            ),
            selected: index == AppCubit.get(context).listIndex,
            selectedTileColor: Colors.grey[400],
            onTap: () {
              AppCubit.get(context).changeListIndex(index);
              AppCubit.get(context).getAddressesModel!.data = model;
              nameController.text = model.data![index].name!;
              cityController.text = model.data![index].city!;
              regionController.text = model.data![index].region!;
              detailsController.text = model.data![index].details!;
              notesController.text = model.data![index].notes!;
              latitudeController.text = model.data![index].latitude!.toString();
              longitudeController.text =
                  model.data![index].longitude!.toString();
              print(model.data![AppCubit.get(context).listIndex].name);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: model!.data!.length,
      );
}
