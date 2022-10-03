import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var formKet =GlobalKey<FormState>();
  var searchController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKet,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormFiled(
                        controller: searchController,
                        type: TextInputType.text,
                        lable: 'Search',
                        validation: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return 'Enter text to search ';
                          }else
                          {
                            return null;
                          }
                        },
                        onsumit: (String text)
                        {
                          SearchCubit.get(context).search(text);
                        },
                        fixIcon: Icons.search
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingStates)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context , index)=> buildFavItem(SearchCubit.get(context).searchModel!.data!.data![index],context, isOldPrice: false),
                          separatorBuilder: (context , index) => MyDivider(),
                          itemCount: SearchCubit.get(context).searchModel!.data!.data!.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );

  }
}


