import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/moduls/search_screen/search_cubit/search_cubit.dart';
import 'package:shop_app/moduls/search_screen/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          print(state);
          if(state is SearchErrorState){
            defaultToast(msg: state.error.toString(), backgroundColor: Colors.red, textColor: Colors.white);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: defaultColor,
              ),
              title: Text(
                'Search',
                style: TextStyle(
                  color: defaultColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  defaultTextForm(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    labelText: 'Search',
                    onChange: (value) {
                      SearchCubit.get(context).getSearchData(text: value);
                    },
                    validate: (value) {},
                    borderRadius: 15,
                    contentPadding: 20,
                    borderColor: defaultColor,
                    labelColor: defaultColor,
                    preIcon: Icon(
                      Icons.search,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => searchItemBuild(
                              SearchCubit.get(context)
                                  .searchModel
                                  .data!.data![index],
                              context),
                          separatorBuilder: (context, index) =>
                              defaultDivider(
                                  double.infinity, defaultColor, 1),
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .data!.data!
                              .length),
                    )

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchItemBuild(SearchData? model, context) => Container(
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
                        style: TextStyle(color: defaultColor, fontSize: 12),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon:
                             Icon(
                                Icons.favorite,
                                size: 20,
                              )
                            // : Icon(
                            //     Icons.favorite_border,
                            //     size: 20,
                            //   )
  ,
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
