import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/srearch_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{

  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search (String text)
  {
    emit(SearchLoadingStates());

    DioHelper.postData(
        url: SEARCH,
      token: token,
        data: {
          'text': text ,
        },
    ).then((value) {
      searchModel =SearchModel.fromJson(value.data);
     // print(value.data.toString());
      emit(SearchSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorStates());
    });
  }

}