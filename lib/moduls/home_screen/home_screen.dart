import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_events.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_states.dart';
import 'package:shop_app/models/categoties_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {
        print(state);
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
      builder: (context, state) {
        return Center(
          child: HomeBloc.get(context).homeData != null &&
                  HomeBloc.get(context).categoriesData != null
              ? productBuilder(HomeBloc.get(context).homeData,
                  HomeBloc.get(context).categoriesData, context)
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model!.data!.banners!
                  .map((e) => Image(
                        image: NetworkImage('${e!.image}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlay: true,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //here for listView
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(color: defaultColor, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => listViewBuild(
                            categoriesModel!.allData!.data![index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: categoriesModel!.allData!.data!.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(color: defaultColor, fontSize: 20),
                  ),
                ],
              ),
            ),
            // here for gridView
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.75,
                children: List.generate(
                    model.data!.products!.length,
                    (index) => buildGridProduct(
                        model.data!.products![index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(UserProductsModel? model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                  image: NetworkImage('${model!.image}'),
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.all(2),
                    color: defaultColor,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(color: defaultColor, fontSize: 12),
                      ),
                      Spacer(),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          HomeBloc.get(context)
                              .add(AddToFavoriteEvent(id: model.id ?? 0));
                        },
                        icon: HomeBloc.get(context).favorites[model.id] ?? false
                            ? Icon(
                                Icons.favorite,
                                size: 20,
                              )
                            : Icon(
                                Icons.favorite_border,
                                size: 20,
                              ),
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

  Widget listViewBuild(CategoriesDataModel? model) => Container(
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              image: NetworkImage('${model!.image}'),
            ),
            Container(
              color: defaultColor.withOpacity(0.6),
              width: 100,
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
}
