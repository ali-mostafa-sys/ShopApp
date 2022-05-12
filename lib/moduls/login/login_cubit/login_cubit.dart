import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_layout.dart';
import 'package:shop_app/models/login_screen_model.dart';
import 'package:shop_app/moduls/login/login_cubit/login_stats.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';
import 'package:shop_app/shared/network/remot/connection_manager/connection.dart';
import 'package:shop_app/shared/network/remot/connection_manager/respons.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import 'package:shop_app/shared/network/remot/end_point.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStat());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModelData loginModelData;
  late Response responseDataLogin;



  LoginRequest request=LoginRequest();
  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingStat());
    final response= await request.postLogin(email: email, password: password).then((value){
      print(value.message);
      print('');
      loginModelData=value;
      print(loginModelData.status);
      token=loginModelData.userData!.token.toString();
      emit(LoginSuccessStat(loginModelData));

    }).catchError((error){
      print(error.toString());
      emit(LoginErrorStat(error.toString()));
    });



  }

  bool obSecure = true;

  void changeObSecure() {
    obSecure = !obSecure;
    emit(LoginChangeObSecureStat());
  }
}
