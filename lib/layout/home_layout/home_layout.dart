import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_events.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_states.dart';

import 'package:shop_app/moduls/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class HomeLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(

      listener: (context, state) {},
      builder: (context,state){
        HomeBloc bloc=HomeBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text(bloc.appBarTitle[bloc.currentIndex],style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold,fontSize: 20),)),
            actions: [
              IconButton(onPressed: (){
                navigatorTo(context, SearchScreen());
              }, icon: Icon(Icons.search,color: defaultColor,))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(

            currentIndex:bloc.currentIndex ,
            onTap: (index){
              bloc.add(OnBottomNavBarChange(index:index));

            },
            items: bloc.bottomItem,
          ),
          body:bloc.screens[bloc.currentIndex] ,
        );
      },
    );
  }
}
