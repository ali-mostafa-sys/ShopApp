//
//
// import 'dart:convert';
//
// import 'package:shop_app/models/login_screen_model.dart';
// import 'package:shop_app/shared/network/remot/connection_manager/respons.dart';
// import 'package:http/http.dart'as http;
//
//
// final String baseUrl=  "https://student.valuxapps.com/api";
//
// Future <Response> logIn (String email,String password) async {
//   String url ='$baseUrl/login';
//   http.Response response= await http.post(
//       Uri.parse(url),
//       headers: {
//         'lang':'en',
//        // 'Content-Type': 'application/json',
//         'accept':'application/json',
//       },
//       body: {
//         'password':password,
//         'email':email,
//       }
//   )  ;
//   var data = json.decode(response.body);
//   if(response.statusCode==200){
//     LoginModelData  userData =LoginModelData.fromJson(data);
//     return Response(statusCode: 200, body: 'logIn Successfully');
//   }else if(response.statusCode==401 || response.statusCode==403){
//     return Response(statusCode: 400, body: null);
//   }else {
//     return Response(statusCode: 500, body: null);
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/categoties_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_screen_model.dart';
import 'package:shop_app/models/profile_user_data.dart';
import 'package:shop_app/models/register_screen_model.dart';
import 'package:shop_app/models/search_model.dart';

class LoginRequest {
  Future<LoginModelData> postLogin(
      {required String email, required String password}) async {
    //  https://student.valuxapps.com/api/
    final uri = Uri.https(
      'student.valuxapps.com',
      '/api/login',
    );
    final response = await http.post(uri,
        headers: {'lang': 'en'}, body: {'email': email, 'password': password});
    final data = jsonDecode(response.body);
    return LoginModelData.fromJson(data);
  }
}

class RegisterRequest {
  Future<RegisterModelData> postRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    final uri = Uri.https('student.valuxapps.com', '/api/register');

    final response = await http.post(uri, headers: {
      'lang': 'en'
    }, body: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    });

    final data = jsonDecode(response.body);

    return RegisterModelData.fromJson(data);
  }
}

class HomeRequest {
  Future<HomeModel> getHomeData({required String token}) async {
    final uri = Uri.https('student.valuxapps.com', '/api/home');
    final client = http.Client();
    final response = await client.get(
      uri,
      headers: {'lang': 'en', 'Authorization': token},
    );
    final data = jsonDecode(response.body);
    return HomeModel.fromJson(data);
  }
}

class CategoriesRequest {
  Future<CategoriesModel> getCategoriesData() async {
    final uri = Uri.https('student.valuxapps.com', '/api/categories');
    final client = http.Client();
    final response = await client.get(uri, headers: {'lang': 'en'});
    final data = jsonDecode(response.body);
    return CategoriesModel.fromJson(data);
  }
}

class FavoriteRequest {
  Future<FavoriteModel> postFavorite(
      {required String token, required int ids}) async {
    final uri = Uri.https('student.valuxapps.com', '/api/favorites');

    final response = await http.post(uri,
        headers: {'lang': 'en', 'Authorization': token},
        body: {'product_id': ids.toString()});
    final data = jsonDecode(response.body);
    return FavoriteModel.fromJson(data);
  }
}

class ProfileRequest {
  Future<ProfileModelData> getProfileData({
    required String token,
  }) async {
    final uri = Uri.https('student.valuxapps.com', '/api/profile');
    final client = http.Client();
    final response = await client.get(
      uri,
      headers: {'lang': 'en', 'Authorization': token},
    );
    final data = jsonDecode(response.body);
    return ProfileModelData.fromJson(data);
  }
}

class UpdateProfileDataRequest {
  Future<ProfileModelData> putDataProfile(
      {required String token,
      required String name,
      required String phone,
      required String email,
      required String password}) async {
    final uri = Uri.https('student.valuxapps.com', '/api/update-profile');
    final client = http.Client();
    final response = await client.put(uri, headers: {
      'lang': 'en',
      'Authorization': token
    }, body: {
      'name': name,
      'phone': phone as String,
      'email': email as String,
      'password': password as String
    });
    final data = jsonDecode(response.body);
    return ProfileModelData.fromJson(data);
  }
}

class SearchProductsRequest {
  Future<SearchModel> postSearch(
      {required String token, required String text}) async {
    final uri = Uri.https('student.valuxapps.com', '/api/products/search');
    final client = http.Client();
    final response = await client.post(uri,
        headers: {'lang': 'en', 'Authorization': token },
        body: {'text': text  });
    final data = jsonDecode(response.body);
    return SearchModel.fromJson(data);
  }
}
