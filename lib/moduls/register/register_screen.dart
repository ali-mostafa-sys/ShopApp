import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_layout.dart';

import 'package:shop_app/moduls/login/shop_login_screen.dart';
import 'package:shop_app/moduls/register/register_bloc/register_bloc.dart';
import 'package:shop_app/moduls/register/register_bloc/register_event.dart';
import 'package:shop_app/moduls/register/register_bloc/register_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocConsumer<RegisterBloc, RegisterStates>(
        listener: (context, state) {
          print(state);
          if (state is RegisterSuccessStates) {
            if (RegisterBloc.get(context).register.status == true) {
              defaultToast(
                  msg: RegisterBloc.get(context).register.message.toString(),
                  backgroundColor: Colors.green,
                  textColor: Colors.white);
              CacheHelper.putStringData(
                      key: 'token',
                      value:
                          RegisterBloc.get(context).register.userData!.token)
                  .then((value) {
                navigatorReplace(context, HomeLayout());
              });
            } else {
              defaultToast(
                  msg: RegisterBloc.get(context).register.message.toString(),
                  backgroundColor: defaultColor,
                  textColor: Colors.white);
            }
          } else if (state is RegisterErrorStates) {
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
                            'SIGN'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'UP'.toUpperCase(),
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Register now to brows our hot offers',
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
                            controller: name,
                            textInputType: TextInputType.text,
                            labelText: 'Name',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Nmae must not empty';
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
                            controller: phone,
                            textInputType: TextInputType.number,
                            labelText: 'Phone',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Phone must not empty';
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
                            controller: email,
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
                            controller: password,
                            textInputType: TextInputType.text,
                            labelText: 'Password',
                            obSecure: RegisterBloc.get(context).obSecure,
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
                            suffixIcon: RegisterBloc.get(context).obSecure
                                ? IconButton(
                                    onPressed: () {
                                      RegisterBloc.get(context).add(ChangeIconObSecure());

                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: defaultColor,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      RegisterBloc.get(context)
                                          .add(ChangeIconObSecure());
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: defaultColor,
                                    )),
                            borderRadius: 15,
                            contentPadding: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: defaultTextForm(
                            controller: rePassword,
                            textInputType: TextInputType.text,
                            labelText: 're-Password',
                            obSecure: RegisterBloc.get(context).obSecure,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password must not empty';
                              } else if (value != password.text) {
                                return 'The password must match';
                              } else {
                                return null;
                              }
                            },
                            preIcon: Icon(
                              Icons.lock,
                              color: defaultColor,
                            ),
                            suffixIcon: RegisterBloc.get(context).obSecure
                                ? IconButton(
                                    onPressed: () {
                                      RegisterBloc.get(context)
                                          .add(ChangeIconObSecure());
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: defaultColor,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      RegisterBloc.get(context)
                                          .add(ChangeIconObSecure());
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
                      state is! RegisterLoadingStates
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: defaultButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterBloc.get(context).add(
                                          RegisterSubmitEvent(
                                              name: name.text,
                                              phone: phone.text,
                                              email: email.text,
                                              password: password.text,context: context));

                                    } else {}
                                  },
                                  text: 'SIGNUP',
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account ?'),
                            TextButton(
                                onPressed: () {
                                  navigatorReplace(context, LoginScreen());
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(color: defaultColor),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
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
