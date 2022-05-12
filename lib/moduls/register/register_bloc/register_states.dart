import 'package:shop_app/models/register_screen_model.dart';

abstract class RegisterStates{}

 class RegisterInitialStates extends RegisterStates{}

class RegisterLoadingStates extends RegisterStates{}

class RegisterSuccessStates extends RegisterStates{
 final RegisterModelData data;

  RegisterSuccessStates(this.data);
}

class RegisterErrorStates extends RegisterStates{
 final String error;

  RegisterErrorStates(this.error);
}


class LoginChangeObSecureStat extends RegisterStates{}


