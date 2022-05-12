import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/profile_user_data.dart';

abstract class HomeStates{}


class HomeInitialState extends HomeStates{}

class ChangeBottomNaveBarIndex extends HomeStates{}

class HomeLoadingState extends HomeStates{}

class HomeSuccessState extends HomeStates{}

class HomeErrorState extends HomeStates{
 final String error;
  HomeErrorState({required this.error});
}


class CategoriesLoadingState extends HomeStates{}
class CategoriesSuccessState extends HomeStates{}

class CategoriesErrorState extends HomeStates{
 final String error;
  CategoriesErrorState({required this.error});
}


class AddToFavoriteStartState extends HomeStates{}
class AddToFavoriteSuccessState extends HomeStates{
 final FavoriteModel favoriteModel;
  AddToFavoriteSuccessState({required this.favoriteModel});
}
class AddToFavoriteErrorState extends HomeStates{
 final String error;
  AddToFavoriteErrorState({required this.error});
}

class StartGetProfileDataState extends HomeStates{}
class SuccessGetProfileDataState extends HomeStates{
  final ProfileModelData profileModelData;
  SuccessGetProfileDataState({required this.profileModelData});
}
class ErrorGetProfileDataState extends HomeStates{
 final String error;
  ErrorGetProfileDataState({required this.error});
}


class StartPutProfileDataState extends HomeStates{}
class SuccessPutProfileDataState extends HomeStates{

}
class ErrorPutProfileDataState extends HomeStates{
 final String error;
 ErrorPutProfileDataState({required this.error});
}