import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_events.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class FavoriteScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc,HomeStates>(
      listener: (context,state){
        if (state is AddToFavoriteSuccessState) {
          defaultToast(
              msg: state.favoriteModel.message.toString(),
              backgroundColor: Colors.green,
              textColor: Colors.white);
        } else if (state is AddToFavoriteErrorState) {
          defaultToast(
              msg: state.error.toString(),
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
      },
      builder: (context,state){
      return ListView.separated(
          itemBuilder: (context,index)=>  HomeBloc.get(context).favorites[HomeBloc.get(context).homeData!.data!.products![index]!.id]??false? favoriteItemBuild(HomeBloc.get(context).homeData!.data!.products![index],context):Container(),
          separatorBuilder: (context,index)=> HomeBloc.get(context).favorites[HomeBloc.get(context).homeData!.data!.products![index]!.id]??false? defaultDivider(double.infinity, defaultColor, 1):Container(),
          itemCount: HomeBloc.get(context).homeData!.data!.products!.length);
    },);
  }
// favoriteItemBuild(HomeBloc.get(context).homeData!.data!.products![2],context)
  Widget favoriteItemBuild(UserProductsModel? model,context)=>Container(
    width: double.infinity,
    height: 120,
    child: Row(
      children: [
        Stack(
          children: [
            Image(
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              image: NetworkImage('${model!.image}'),
            ),
            if(model.discount!=0)

              Container(
                padding: EdgeInsets.all( 2),
                color: defaultColor,
                child: Text('DISCOUNT',style: TextStyle(fontSize: 8,color: Colors.white),),
              ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(color: defaultColor,fontSize: 12),
                  ),
                  Spacer(),
                  if(model.discount!=0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(color: Colors.grey,fontSize: 10,decoration: TextDecoration.lineThrough),
                    ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: (){

                      HomeBloc.get(context).add(AddToFavoriteEvent(id: model.id??0));



                    },
                    icon:
                    HomeBloc.get(context).favorites[model.id]??false?Icon(Icons.favorite,size: 20,):Icon(Icons.favorite_border,size: 20,),iconSize: 20,),

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}