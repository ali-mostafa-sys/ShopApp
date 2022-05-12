import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_events.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_states.dart';
import 'package:shop_app/layout/home_layout/home_layout.dart';
import 'package:shop_app/models/categoties_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_screen_model.dart';
import 'package:shop_app/models/profile_user_data.dart';
import 'package:shop_app/moduls/categories_screen/categories_screen.dart';
import 'package:shop_app/moduls/favorite_screen/favorite_screen.dart';
import 'package:shop_app/moduls/home_screen/home_screen.dart';
import 'package:shop_app/moduls/setting_screen/setting_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';
import 'package:shop_app/shared/network/remot/connection_manager/connection.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  static HomeBloc get(context) => BlocProvider.of(context);

  // here for bottomNavigationBar
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];
  List<String> appBarTitle = ['Home', 'Categories', 'Favorite', 'Settings'];
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  // here for home page requesting
  late HomeRequest request = HomeRequest();
  HomeModel? homeData;
  late Map<int?, bool?> favorites = {};

  // here for categories page request
  CategoriesRequest categoriesRequest = CategoriesRequest();
  CategoriesModel? categoriesData;

  // here add to favorite request
  late FavoriteRequest favoriteRequest = FavoriteRequest();
  late FavoriteModel favoriteModel;

  // here to get profile
  ProfileRequest profileRequest = ProfileRequest();
  late ProfileModelData? profileModelData;

  // here for put data
  UpdateProfileDataRequest updateProfileDataRequest = UpdateProfileDataRequest();
  late LoginModelData? loginModelData;

  HomeBloc() : super(HomeInitialState()) {
    on<OnBottomNavBarChange>((event, emit) {
      currentIndex = event.index;
      emit(ChangeBottomNaveBarIndex());
    });
    on<OneOpenPage>((event, emit) async {
      emit(HomeLoadingState());
     // String token = CacheHelper.getStringData(key: 'token');
      final response = await request.getHomeData(token: token).then((value) {
        homeData = value;
        homeData!.data!.products!.forEach((element) {
          favorites.addAll({element!.id: element.inFavorites});
        });

        emit(HomeSuccessState());
      }).catchError((error) {
        emit(HomeErrorState(error: error.toString()));
      });
    });
    on<GetCategories>((event, emit) async {
      emit(CategoriesLoadingState());
      final categoriesResponse =
      await categoriesRequest.getCategoriesData().then((value) {
        categoriesData = value;
        emit(CategoriesSuccessState());
      }).catchError((error) {
        emit(CategoriesErrorState(error: error.toString()));
      });
    });
    on<AddToFavoriteEvent>((event, emit) async {
     // String token = CacheHelper.getStringData(key: 'token');
      print(token);

      if (favorites[event.id] == true) {
        favorites[event.id] = false;
      } else {
        favorites[event.id] = true;
      }

      emit(AddToFavoriteStartState());
      final response = await favoriteRequest
          .postFavorite(token: token, ids: event.id)
          .then((value) {
        favoriteModel = value;
        if (favoriteModel.status == false) {
          if (favorites[event.id] == true) {
            favorites[event.id] = false;
          } else {
            favorites[event.id] = true;
          }
        }

        emit(AddToFavoriteSuccessState(favoriteModel: favoriteModel));
      }).catchError((error) {
        if (favorites[event.id] == true) {
          favorites[event.id] = false;
        } else {
          favorites[event.id] = true;
        }

        emit(AddToFavoriteErrorState(error: error.toString()));
      });
    });
    on<GetProfileDataEvent>((event, emit) async {
     // String token = CacheHelper.getStringData(key: 'token');
      print(token);
      emit(StartGetProfileDataState());
      final response = await profileRequest.getProfileData(token: token).then((
          value) {
        profileModelData = value;
        emit(SuccessGetProfileDataState(profileModelData: profileModelData!));
      }).catchError((error) {
        print('${error.toString()}');
        emit(ErrorGetProfileDataState(error: error.toString()));
      });
    });
    on<PutProfileDataEvent>((event, emit) async {
     // String token = CacheHelper.getStringData(key: 'token');
      emit(StartPutProfileDataState());
      final response = await updateProfileDataRequest.putDataProfile(
          token: token,
          name: event.name,
          phone: event.phone,
          email: event.email,
          password: event.password).then((value) {
        profileModelData=value;
            emit(SuccessPutProfileDataState());
      }).catchError((error){
        emit(ErrorPutProfileDataState(error: error.toString()));
      });
    });
  }
}
