import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);

      emit(AppLoginSuccessState(loginModel!));
    }).catchError((error) {
      print('error: ${error.toString()}');
      emit(AppLoginFailureState(error.toString()));
    });
  }
}
