import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_layout.dart';
import 'package:shop_app/models/register_screen_model.dart';
import 'package:shop_app/moduls/login/login_cubit/login_cubit.dart';
import 'package:shop_app/moduls/register/register_bloc/register_event.dart';
import 'package:shop_app/moduls/register/register_bloc/register_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';
import 'package:shop_app/shared/network/remot/connection_manager/connection.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  late bool obSecure = true;
  late RegisterModelData register;
  late RegisterRequest response = RegisterRequest();

 static RegisterBloc get(BuildContext context)=>BlocProvider.of(context);

  RegisterBloc() : super(RegisterInitialStates()) {
    on<ChangeIconObSecure>((event, emit) {
      obSecure = !obSecure;
      emit(LoginChangeObSecureStat());
    });
    on<RegisterSubmitEvent>((event,emit)async{
      emit(RegisterLoadingStates());
      final data = await response
          .postRegister(
          name: event.name,
          phone: event.phone,
          email: event.email,
          password: event.password)
          .then((value) {
        register = value;
        token=register.userData!.token!;

        print(register.message);
        emit(RegisterSuccessStates(register));
      }).catchError((error) {
        print(error.toString());
        emit(RegisterErrorStates(error.toString()));
      });
    });
  }



}

