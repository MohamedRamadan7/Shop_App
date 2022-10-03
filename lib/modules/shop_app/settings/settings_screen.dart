import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var nameController =TextEditingController();
    var emailController =TextEditingController();
    var phoneController =TextEditingController();


    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).userModel;
        nameController.text= model!.data!.name!;
        emailController.text= model.data!.email!;
        phoneController.text= model.data!.phone!;
        return ShopCubit.get(context).userModel != null ? Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children:
              [
                if(state is ShopLoadingUpdateUserState)
                LinearProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormFiled(
                  controller: nameController,
                  type: TextInputType.name,
                  validation: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Name must not be empty';
                    }
                    return null;

                  },
                  lable: 'Name',
                  fixIcon: Icons.person,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormFiled(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validation: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Email must not be empty';
                    }
                    return null;

                  },
                  lable: 'Email',
                  fixIcon: Icons.email,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormFiled(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validation: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Phone must not be empty';
                    }
                    return null;

                  },
                  lable: 'Phone',
                  fixIcon: Icons.phone,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  function: ()
                  {
                    if(formKey.currentState!.validate())
                      {
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }

                  },
                  text: 'UPDATE',
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                    function: ()
                    {
                      signOut(context);
                    },
                    text: 'LogOut',
                ),
              ],
            ),
          ),
        ) : Center(child: CircularProgressIndicator());
      },

    );
  }
}