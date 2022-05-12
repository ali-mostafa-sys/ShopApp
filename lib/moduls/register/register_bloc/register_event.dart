import 'package:flutter/cupertino.dart';

@immutable
abstract class RegisterEvents {}

class RegisterSubmitEvent extends RegisterEvents {
  final String name;
  final String phone;
  final String email;
  final String password;
  final BuildContext context;

  RegisterSubmitEvent(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password,required this.context});
}

class ChangeIconObSecure extends RegisterEvents {}
