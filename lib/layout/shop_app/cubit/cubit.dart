import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/favories_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super( ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  var currentIndex=0;
  List<Widget> bottomScreen=
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomNave(index)
  {
    currentIndex =index;
    emit(ShopChangeBottomNaveState());
  }

  Map<int, bool>? favorites ={};
  HomeModel? homeModel;
  void getHomeData ()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
    token:token,
    ).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products.forEach((element)
        {
          favorites!.addAll({
            element.id!: element.inFavorites!
          });
        });
        print(favorites.toString());

        //  print(homeModel!.data!.banners[0].image);
        // print(homeModel!.status);
        emit(ShopSuccessHomeDataState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });

  }

  CategoriesModel? categoriesModel;
  void getCategoriesData()
  {

    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStaState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });

  }

  ChangeFavoritesModel ? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites![productId] = !favorites![productId]!;
    emit(ShopChangeFavoritesStaState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':productId
      },
      token: token,
    ).then((value) {
         if (  categoriesModel!.status == false )
           {
             favorites![productId] = !favorites![productId]!;
             print('I am mohamed');
           }else
             {
               print('I not mohamed');
               getFavoritesData();
             }

      changeFavoritesModel =ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessChangeFavoritesStaState(changeFavoritesModel!));

    }).catchError((error){

     favorites![productId] = !favorites![productId]!;
     print('error is :${error}');
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData()
  {
    emit(ShopLoadingGetFavoritesStaState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
     // print('mohamed mmmm');
      emit(ShopGetFavoritesStaState());

    }).catchError((error){
      print(' error is :${error.toString()}');
      emit(ShopErrorGetFavoritesState());
    });

  }


  ShopLoginModel? userModel;
  void getUserData ()
  {
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });

  }

  void updateUserData ({
  required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,

      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });

  }


}