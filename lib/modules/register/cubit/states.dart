import 'package:shop_app/models/login_model.dart';

abstract class AppRegisterStates {}

class AppRegisterInitialState extends AppRegisterStates {}

class AppRegisterLoadingState extends AppRegisterStates {}

class AppRegisterSuccessState extends AppRegisterStates {
  final LoginModel registerModel;

  AppRegisterSuccessState(this.registerModel);
}

class AppRegisterFailureState extends AppRegisterStates {
  final String error;

  AppRegisterFailureState(this.error);
}
