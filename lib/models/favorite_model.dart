class FavoriteModel {
  bool? status;
  String? message;

  FavoriteModel({required this.status, required this.message});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as bool;
    final message = json['message'] as String;
    return FavoriteModel(status: status, message: message);
  }
}
