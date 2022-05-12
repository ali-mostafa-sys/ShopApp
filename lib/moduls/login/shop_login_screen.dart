import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_layout.dart';

import 'package:shop_app/moduls/login/login_cubit/login_cubit.dart';
import 'package:shop_app/moduls/login/login_cubit/login_stats.dart';
import 'package:shop_app/moduls/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          print(state);
          if (state is LoginSuccessStat) {
            if (LoginCubit.get(context).loginModelData.status == true) {
              defaultToast(
                  msg:
                      LoginCubit.get(context).loginModelData.message.toString(),
                  backgroundColor: Colors.green,
                  textColor: Colors.white);
              CacheHelper.putStringData(key: 'token', value: LoginCubit.get(context).loginModelData.userData!.token).then((value) {
                navigatorReplace(context, HomeLayout());
              });
            } else {
              defaultToast(
                  msg:
                      LoginCubit.get(context).loginModelData.message.toString(),
                  backgroundColor: defaultColor,
                  textColor: Colors.white);
            }
          } else if (state is LoginErrorStat) {
            defaultToast(
                msg: state.error.toString(),
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'In'.toUpperCase(),
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Login now to brows our hot offers',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: defaultTextForm(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            labelText: 'Email',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Email must not empty';
                              } else {
                                return null;
                              }
                            },
                            preIcon: Icon(
                              Icons.email_outlined,
                              color: defaultColor,
                            ),
                            borderRadius: 15,
                            contentPadding: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: defaultTextForm(
                            controller: passwordController,
                            textInputType: TextInputType.text,
                            labelText: 'Password',
                            obSecure: LoginCubit.get(context).obSecure,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password must not empty';
                              } else {
                                return null;
                              }
                            },
                            preIcon: Icon(
                              Icons.lock,
                              color: defaultColor,
                            ),
                            suffixIcon: LoginCubit.get(context).obSecure
                                ? IconButton(
                                    onPressed: () {
                                      LoginCubit.get(context).changeObSecure();
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: defaultColor,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      LoginCubit.get(context).changeObSecure();
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: defaultColor,
                                    )),
                            borderRadius: 15,
                            contentPadding: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      state is! LoginLoadingStat
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: defaultButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    } else {}
                                  },
                                  text: 'LOGIN',
                                  fontSize: 25,
                                  context: context,
                                  borderRadiusOfButton: 40,
                                  fitColor: defaultColor,
                                  internalPadding: 15,
                                  textColor: Colors.white),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text('Don\`t have an account'),
                            TextButton(
                                onPressed: () {
                                  navigatorReplace(context, RegisterScreen());
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(color: defaultColor),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
