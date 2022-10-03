import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/favories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return state is ShopLoadingGetFavoritesStaState ?ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context , index)=> buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
            separatorBuilder: (context , index) => MyDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length): Center(child: CircularProgressIndicator());
      },
    );
  }


}

Widget buildFavItem(model, context,{bool? isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:  NetworkImage('${model.image}'),
              height: 120,
              width:  120,


            ),
            if(model.discount != 0 && isOldPrice == true)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.1,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.1,
                        color:defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if(model.discount !=0  && isOldPrice == true )
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                          fontSize: 10.0,
                          height: 1.1,
                          color:Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(model.id!);
                          // print(model.id);

                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: ShopCubit.get(context).favorites![model.id!]??true? defaultColor :Colors.grey ,
                          child: Icon(Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);