import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context , state)
    {
      if ( state is ShopSuccessChangeFavoritesStaState)
        {
          if(state.model.status==false)
            showToast(text:'${state.model.message}', state: ToastStates.ERROR);
        }

    },
    builder: (context , state)
    {
      return ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null  ? ProductsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context) : Center(child: CircularProgressIndicator());
    }
    );
  }


  Widget ProductsBuilder(HomeModel model, CategoriesModel categoriesModel,context)=> SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: model.data!.banners.map((e) => Image(image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,

          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context , index) => buildCategories(categoriesModel.data!.data![index]),
                    separatorBuilder: (context , index) => SizedBox(
                      width:10 ,
                    ),
                    itemCount: categoriesModel.data!.data!.length),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'News Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics:NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1/1.58,
            children:List.generate(model.data!.products.length ,
                    (index) =>buildGridProducts(model.data!.products[index],context),
            ),
          ),
        ),
      ],
    ),
  ); 

  Widget buildCategories (DataModel model) => Container(
    width: 100,
    height: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage('${model.image}'),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: double.infinity,
          child: Text(
            '${model.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(

              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildGridProducts (ProductModel model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:  NetworkImage('${model.image}'),
              height: 200,
              width:  double.infinity,

            ),
            if(model.discount !=0)
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
        Padding(
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
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      height: 1.1,
                      color:defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount !=0)
                  Text(
                    '${model.oldPrice.round()}',
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
                    print(model.id);

                  },
                    icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context).favorites![model.id!]??true ? defaultColor :Colors.grey ,
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
      ],
    ),
  );

}


