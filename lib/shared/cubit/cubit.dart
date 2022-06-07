// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/product_detaild_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;
  HomeModel? homeModel;
  CategoryModel? categoryModel;
  FavouritesModel? favouritesModel;
  Map<int, bool> favourites = {};

  void changeBottomTabIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavTab());
  }

  void getHomeData() {
    emit(AppHomeLoadingState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        //printFullText(value!.data);
        homeModel!.data!.products.forEach(
          (element) {
            //print(element.inFavorites!);
            favourites.addAll({
              element.id!: element.inFavorites!,
            });
          },
        );
        //print(favourites);
        printFullText(homeModel!.data!.products[0].inFavorites.toString());
        emit(AppHomeSuccessState());
      },
    ).catchError(
      (error) {
        emit(AppHomeFailureState());
      },
    );
  }

  void getCategoriesData() {
    //emit(AppHomeLoadingState());

    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      //print(categoryModel!.data);
      emit(AppHomeCategoriesSuccessState());
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppHomeCategoriesFailureState());
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;

  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(AppChangeFavouritesState());

    DioHelper.postData(
      url: FAVOURITES,
      token: token,
      data: {'product_id': productId},
    ).then(
      (value) {
        changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
        if (!changeFavouritesModel!.status!) {
          favourites[productId] = !favourites[productId]!;
        } else {
          getFavoritesData();
        }
        emit(AppChangeFavouritesSuccessState());
      },
    ).catchError(
      (error) {
        emit(AppChangeFavouritesFailureState());
      },
    );
  }

  void getFavoritesData() {
    emit(AppGetFavouritesLoadingState());

    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      printFullText(favouritesModel!.data.toString());
      emit(AppGetFavouritesSuccessState());
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppGetFavouritesFailureState());
    });
  }

  UserData? userModel;
  void getUserData() {
    emit(AppGetProfileLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = UserData.fromJson(value.data['data']);
      print(userModel!.name);
      emit(AppGetProfileSuccessState());
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppGetProfileFailureState());
    });
  }

  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(AppUpdateProfileLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
      token: token,
    ).then((value) {
      userModel = UserData.fromJson(value.data['data']);

      emit(AppUpdateProfileSuccessState());
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppUpdateProfileFailureState());
    });
  }

  ProductDetailsModel? productDetailsModel;
  void getProductDetailsData(int id) {
    emit(AppGetProductDetailsLoadingState());
    DioHelper.getData(
      url: '$GET_PRODUCT$id',
      token: token,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print(value.data);
      emit(AppGetProductDetailsSuccessState());
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppGetProductDetailsFailureState());
    });
  }

  CartModel? cartModel;
  void addToCart(int productId) {
    emit(AppAddToCartLoadingState());
    DioHelper.postData(
      url: CARTS,
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      //printFullText(value.data);
      //cartModel = CartModel.fromJson(value.data);
      //print('data: ${data}');
      emit(AppAddToCartSuccessState());

      getCartData();
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppAddToCartFailureState());
    });
  }

  void getCartData() {
    emit(AppGetCartDataLoadingState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      //print(value.data);
      emit(AppGetCartDataSuccessState());
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppGetCartDataFailureState());
    });
  }

  void deleteFromCart(int cartItemId) {
    emit(AppDeleteCartDataLoadingState());
    DioHelper.deleteData(
      url: '$CARTS/$cartItemId',
      token: token,
    ).then((value) {
      //cartModel = CartModel.fromJson(value.data);
      print(value.data);
      emit(AppDeleteCartDataSuccessState());
      getCartData();

      //emit(AppGetCartDataLoadingState());
    }).catchError((error) {
      print('error:${error.toString()}');
      emit(AppDeleteCartDataFailureState());
    });
  }

  int? cartQuantity = 0;

  void incrementQuantity() {
    cartQuantity = cartQuantity! + 1;
    emit(AppCartQuantityIncrementState());
  }

  void decrementQuantity() {
    if (cartQuantity! > 0) {
      cartQuantity = cartQuantity! - 1;
    } else {
      cartQuantity = 0;
    }
    emit(AppCartQuantityDecrementState());
  }
}
