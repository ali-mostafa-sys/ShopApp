class RegisterModelData {
  final bool? status;
  final String? message;
  final UserData? userData;

  RegisterModelData(
      {required this.status, required this.message,required this.userData} );
// required this.userData}
  factory RegisterModelData.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final message = json['message'];
    //final userDataForm = json['data'];
    final userData= json['data']!=null? UserData.fromJson(json['data']):null;
    return RegisterModelData(status: status, message: message,userData: userData);
  }
}
//  userData: userData

class UserData {
  final String? name;
  final String? phone;
  final String? email;
  final int? id;
  final String? image;
  final String? token;

  UserData({
    required this.name,
    required this.phone,
    required this.email,
    required this.id,
    required this.image,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final email = json['email'];
    final phone = json['phone'];
    final image = json['image'];
    final token = json['token'];
    return UserData(
        name: name,
        phone: phone,
        email: email,
        id: id,
        image:image,
        token: token);
  }
}
