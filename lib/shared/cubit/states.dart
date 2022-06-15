import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/models/product_detaild_model.dart';

abstract class AppState {}

class AppInitialState extends AppState {}

class AppChangeBottomNavTab extends AppState {}

class AppSelectPaymentMethod extends AppState {}

class AppChangeListIndexState extends AppState {}

class AppChangeisFormState extends AppState {}

class AppChangeCartCountState extends AppState {}

class AppHomeLoadingState extends AppState {}

class AppisLoadingState extends AppState {}

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

class AppCreateAddressLoadingState extends AppState {}

class AppCreateAddressSuccessState extends AppState {}

class AppCreateAddressFailureState extends AppState {}

class AppGetAddressesLoadingState extends AppState {}

class AppGetAddressesSuccessState extends AppState {}

class AppGetAddressesFailureState extends AppState {}

class AppDeleteAddressLoadingState extends AppState {}

class AppDeleteAddressSuccessState extends AppState {}

class AppDeleteAddressFailureState extends AppState {}

class AppAddOrderLoadingState extends AppState {}

class AppAddOrderSuccessState extends AppState {
  final OrderModel? orderModel;

  AppAddOrderSuccessState(this.orderModel);
}

class AppAddOrderFailureState extends AppState {}

class AppGetOrdersLoadingState extends AppState {}

class AppGetOrdersSuccessState extends AppState {}

class AppGetOrdersFailureState extends AppState {}

class AppCancelOrderLoadingState extends AppState {}

class AppCancelOrderSuccessState extends AppState {}

class AppCancelOrderFailureState extends AppState {}
