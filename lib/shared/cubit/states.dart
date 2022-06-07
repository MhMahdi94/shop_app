import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/product_detaild_model.dart';

abstract class AppState {}

class AppInitialState extends AppState {}

class AppChangeBottomNavTab extends AppState {}

class AppHomeLoadingState extends AppState {}

class AppHomeSuccessState extends AppState {}

class AppHomeFailureState extends AppState {}

class AppHomeCategoriesSuccessState extends AppState {}

class AppHomeCategoriesFailureState extends AppState {}

class AppChangeFavouritesState extends AppState {}

class AppChangeFavouritesSuccessState extends AppState {}

class AppChangeFavouritesFailureState extends AppState {}

class AppGetFavouritesLoadingState extends AppState {}

class AppGetFavouritesSuccessState extends AppState {}

class AppGetFavouritesFailureState extends AppState {}

class AppGetProfileLoadingState extends AppState {}

class AppGetProfileSuccessState extends AppState {}

class AppGetProfileFailureState extends AppState {}

class AppUpdateProfileLoadingState extends AppState {}

class AppUpdateProfileSuccessState extends AppState {}

class AppUpdateProfileFailureState extends AppState {}

class AppGetProductDetailsLoadingState extends AppState {}

class AppGetProductDetailsSuccessState extends AppState {
  final ProductDetailsModel? productDetailsModel;

  AppGetProductDetailsSuccessState(this.productDetailsModel);
}

class AppGetProductDetailsFailureState extends AppState {}

class AppAddToCartLoadingState extends AppState {}

class AppAddToCartSuccessState extends AppState {}

class AppAddToCartFailureState extends AppState {}

class AppGetCartDataLoadingState extends AppState {}

class AppGetCartDataSuccessState extends AppState {}

class AppGetCartDataFailureState extends AppState {}

class AppDeleteCartDataLoadingState extends AppState {}

class AppDeleteCartDataSuccessState extends AppState {}

class AppDeleteCartDataFailureState extends AppState {}

class AppCartQuantityIncrementState extends AppState {}

class AppCartQuantityDecrementState extends AppState {}

class AppGetCategoryDetailsLoadingState extends AppState {}

class AppGetCategoryDetailsSuccessState extends AppState {}

class AppGetCategoryDetailsFailureState extends AppState {}
