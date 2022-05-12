import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_states.dart';
import 'package:shop_app/models/categoties_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => listViewCategories(HomeBloc.get(context).categoriesData!.allData!.data![index]),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount:
                HomeBloc.get(context).categoriesData!.allData!.data!.length);
      },
    );
  }

  Widget listViewCategories(CategoriesDataModel? model) => Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage('${model!.image}'),
                ),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${model.name}',style: TextStyle(fontSize: 18,),),
                ],
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
  );
}
