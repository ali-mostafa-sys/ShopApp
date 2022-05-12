abstract class HomeEvents{}


class OnBottomNavBarChange extends HomeEvents{
  int index;
  OnBottomNavBarChange({required this.index});
}


class OneOpenPage extends HomeEvents{

}

class GetCategories extends HomeEvents{}

class AddToFavoriteEvent extends HomeEvents{
  int id;
  AddToFavoriteEvent({required this.id});
}

class GetProfileDataEvent extends HomeEvents{}


class PutProfileDataEvent extends HomeEvents{
  final String name;
  final String email;
  final String phone;
  final String password;

  PutProfileDataEvent({required this.name,required this.email,required this.phone,required this.password});
}