import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppSearchCubit extends Cubit<AppSearchStates> {
  AppSearchCubit() : super(AppSearchInitialState());

  static AppSearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void productSearch({required String text}) {
    emit(AppSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      print(value.data);
      searchModel = SearchModel.fromJson(value.data);

      emit(AppSearchSuccessState(searchModel!));
    }).catchError((error) {
      print('error: ${error.toString()}');
      emit(AppSearchFailureState(error.toString()));
    });
  }
}
