
//GET

// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f47f55b570fd4498b5d02e3e5599377e

//baseurl  https://newsapi.org/
//method() v2/top-headlines?
// queries country=eg&category=business&apiKey=f47f55b570fd4498b5d02e3e5599377e

//  https://newsapi.org/v2/everything?q=tesla&from=2022-02-06&sortBy=publishedAt&apiKey=f47f55b570fd4498b5d02e3e5599377e


import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut (context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
    {
      navigateAndFinish(context, ShopLodginScreen());
    }
  });
}

String? token ='';

