import 'package:shop_app/models/login_screen_model.dart';

abstract class LoginStates{}

class LoginInitialStat extends LoginStates{}

class LoginLoadingStat extends LoginStates{}

class LoginSuccessStat extends LoginStates{
  final LoginModelData loginModelData;

 LoginSuccessStat(this.loginModelData);
}
class LoginErrorStat extends LoginStates{
  final String error;

  LoginErrorStat(this.error);

}
class LoginChangeObSecureStat extends LoginStates{}






