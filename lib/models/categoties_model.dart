class CategoriesModel{
  bool? status;
  CategoriesAllDataModel? allData;
  CategoriesModel({required this.status,required this.allData});

  factory CategoriesModel.fromJson(Map<String,dynamic >json){
    final status=json['status'];
    final data =json['data'];
    final allData=CategoriesAllDataModel.fromJson(data);
    return CategoriesModel(status: status, allData: allData);
  }
}

class CategoriesAllDataModel{
  int? currentPage;
  List<CategoriesDataModel>? data;
  CategoriesAllDataModel({required this.currentPage,required this.data});
   factory CategoriesAllDataModel.fromJson(Map<String,dynamic>json){
     final currentPage=json['current_page'];
     final realData=json['data']as List;
     final data=realData.map((e) => CategoriesDataModel.fromJson(e)).toList();
     return CategoriesAllDataModel(currentPage: currentPage, data: data);
   }

}

class CategoriesDataModel{
  int? id;
  String? name;
  String? image;
  CategoriesDataModel({required this.id,required this.name,required this.image});
  factory CategoriesDataModel.fromJson(Map<String,dynamic>json){
    final id=json['id'];
    final name=json['name'];
    final image=json['image'];
    return CategoriesDataModel(id: id, name: name, image: image);
  }
}