class ProfileModelData {
  final bool? status;
  final String? message;
  final UserData? userData;

  ProfileModelData(
      {required this.status, required this.message,required this.userData} );
// required this.userData}
  factory ProfileModelData.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final message = json['message'];
    final userData= json['data']!=null? UserData.fromJson(json['data']):null;
    return ProfileModelData(status: status, message: message,userData: userData);
  }
}
//  userData: userData

class UserData {
  final String? name;
  final String? phone;
  final String? email;
  final int? id;
  final int? points;
  final int? credit;
  final String? token;

  UserData({
    required this.name,
    required this.phone,
    required this.email,
    required this.id,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final email = json['email'];
    final phone = json['phone'];
    final points = json['points'];
    final credit = json['credit'];
    final token = json['token'];
    return UserData(
        name: name,
        phone: phone,
        email: email,
        id: id,
        points: points,
        credit: credit,
        token: token);
  }
}
