class HomeModel {
  bool? status;
  UserDataModel? data;
   HomeModel({required this.status,required this.data});
   factory HomeModel.fromJson(Map<String,dynamic>json){
     final status=json['status'];
     final userData=json['data'];
     final data=UserDataModel.fromJson(userData);
     return HomeModel(status: status, data: data);
   }
}

class UserDataModel {
  List<UserBannersModel?>? banners;
  List<UserProductsModel?>? products;
  UserDataModel({required this.banners,required this.products});
   factory UserDataModel.fromJson(Map<String,dynamic>json){
     final bannersData=json['banners']as List;
     final banners=bannersData.map((e) =>UserBannersModel.fromJson(e)).toList();
     final productData=json['products']as List;
     final products=productData.map((e) => UserProductsModel.fromJson(e)).toList();
     return UserDataModel(banners: banners, products: products);
   }

}

class UserBannersModel {
  int? id;
  String? image;

  UserBannersModel({required this.id, required this.image});

  factory UserBannersModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final image = json['image'];
    return UserBannersModel(id: id, image: image);
  }
}

class UserProductsModel {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  UserProductsModel(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.image,
      required this.name,
      required this.inFavorites,
      required this.inCart});

  factory UserProductsModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final price = json['price'];
    final oldPrice = json['old_price'];
    final discount = json['discount'];
    final image = json['image'];
    final name = json['name'];
    final inFavorites = json['in_favorites'];

    final inCart = json['in_cart'];
    return UserProductsModel(
        id: id,
        price: price,
        oldPrice: oldPrice,
        discount: discount,
        image: image,
        name: name,
        inFavorites: inFavorites,
        inCart: inCart);
  }
}
