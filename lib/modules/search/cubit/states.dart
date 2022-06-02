import 'package:shop_app/models/search_model.dart';

abstract class AppSearchStates {}

class AppSearchInitialState extends AppSearchStates {}

class AppSearchLoadingState extends AppSearchStates {}

class AppSearchSuccessState extends AppSearchStates {
  final SearchModel searchModel;

  AppSearchSuccessState(this.searchModel);
}

class AppSearchFailureState extends AppSearchStates {
  final String error;

  AppSearchFailureState(this.error);
}
