import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/layout/shoo_app/cubit/cubit.dart';
// import 'package:shop_app/layout/shoo_app/shop_layout.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_app/onboarding/on_boarding.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
//import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark= CacheHelper.getData(key:'isDark');
  Widget widget;
  bool? onBoarding= CacheHelper.getData(key:'onBoarding');
  token= CacheHelper.getData(key:'token');
  if(onBoarding != null && token != null )
    {
      if(token != null) widget =ShopLayout();
      else widget =ShopLodginScreen();
    }else
      {
        widget = OnBoarding();
      }

  runApp(MyApp(widget));

}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:lightTheme ,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: startWidget ,
      ),
    );
  }
}
