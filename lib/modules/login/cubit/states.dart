import 'package:shop_app/models/login_model.dart';

abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {
  final LoginModel loginModel;

  AppLoginSuccessState(this.loginModel);
}

class AppLoginFailureState extends AppLoginStates {
  final String error;

  AppLoginFailureState(this.error);
}
