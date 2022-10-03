import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNaveState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesStaState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoritesStaState extends ShopStates{}

class ShopSuccessChangeFavoritesStaState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStaState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesStaState extends ShopStates{}

class ShopGetFavoritesStaState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
   final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates{}

