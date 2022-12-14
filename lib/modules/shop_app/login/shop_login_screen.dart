import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/register/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLodginScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state){
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status == true)
                {

                  print(state.loginModel.message);
                  print(state.loginModel.data!.token);
                  CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                    token= CacheHelper.getData(key:'token');
                    navigateAndFinish(context,ShopLayout());
                  });
                }else
                  {
                    print(state.loginModel.message);
                    showToast(text: "${state.loginModel.message}",
                        state:ToastStates.ERROR );
                  }

            }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validation: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return ' Enter your Email Address';
                            }
                          },
                          lable:'Email Address',
                          fixIcon: Icons.email,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validation: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Password is too short';
                            }
                          },
                          lable:'Password',
                          fixIcon: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffix,
                          ispassword: ShopLoginCubit.get(context).isPassword,
                            sufixpressd: ()
                            {
                              ShopLoginCubit.get(context).ChangePasswordVisibility();
                            },
                          onsumit: (value)
                            {
                              if(formkey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                print('email ${emailController.text}');
                                print('pass ${passwordController.text}');
                              }
                            }
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is! ShopLoginLoadingState ? defaultButton(
                            function: ()
                            {
                              if(formkey.currentState!.validate())
                                {

                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  print('email ${emailController.text}');
                                  print('pass ${passwordController.text}');

                                }
                            },
                            text: 'login',
                            isUberCase: true
                        ): Center(child: CircularProgressIndicator()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don \'t have account?'
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                navigateTo(context,ShopRegisterScreen());
                              },
                              child: Text(
                                  'REGISTER'
                              ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
