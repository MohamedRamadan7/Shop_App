
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        }
        ).then((value){
          print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);

          emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){

      emit(ShopLoginErrorState(error.toString()));
      print('error is = ${error.toString()}');
    });
  }
  IconData suffix= Icons.visibility;
  bool isPassword=true;

  void ChangePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_off_outlined :Icons.visibility;
    emit(ShopChangePasswordVisibilityState());
  }

}