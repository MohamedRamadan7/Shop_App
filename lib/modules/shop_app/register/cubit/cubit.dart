
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/register_model.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=> BlocProvider.of(context);

  ShopRegisterModel? registerModel;

  void userRegister({
  required String email,
  required String password,
    required String name,
    required String phone,
})
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }
        ).then((value){
          print(value.data);
          registerModel = ShopRegisterModel.fromJson(value.data);

          emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){

      emit(ShopRegisterErrorState(error.toString()));
      print('error is = ${error.toString()}');
    });
  }
  IconData suffix= Icons.visibility;
  bool isPassword=true;

  void ChangePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_off_outlined :Icons.visibility;
    emit(ShopChangeRegisterPasswordVisibilityState());
  }

}