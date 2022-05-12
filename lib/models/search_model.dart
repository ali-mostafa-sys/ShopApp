class SearchModel{
  bool? status;
  Data? data;
  SearchModel({required this.status,required this.data});

 factory SearchModel.fromJson(Map<String,dynamic>json){
  final status=json['status'];
  final allData=json['data'];
  final data=Data.fromJson(allData);
   return SearchModel(status: status,data: data);

 }
}
class Data{
  List<SearchData>? data;
  Data({required this.data});
  factory Data.fromJson(Map<String,dynamic>json){
    final allData=json['data'] as List;
    final data=allData.map((e) => SearchData.fromJson(e)).toList();
    return Data(data: data);
  }
}


class SearchData{
  int? id;
  dynamic? price;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  SearchData({required this.id,required this.price,required this.image,required this.name,required this.in_favorites,required this.in_cart});

  factory SearchData.fromJson(Map<String,dynamic>json){
    final id=json['id'];
    final price=json['price'];
    final image=json['image'];
    final name=json['name'];
    final in_favorites=json['in_favorites'];
    final in_cart=json['in_cart'];
    return SearchData(id: id, price: price, image: image, name: name, in_favorites: in_favorites, in_cart: in_cart);


  }


}