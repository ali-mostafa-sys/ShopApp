import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_events.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_states.dart';
import 'package:shop_app/moduls/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {
        if(state is SuccessPutProfileDataState){
          HomeBloc.get(context).add(PutProfileDataEvent(
              name: nameController.text,
              email: emailController.text,
              phone: phoneController.text,
              password: passwordController.text));
        }
      },
      builder: (context, state) {
        nameController.text =
            HomeBloc.get(context).profileModelData!.userData!.name.toString();
        emailController.text =
            HomeBloc.get(context).profileModelData!.userData!.email.toString();
        phoneController.text =
            HomeBloc.get(context).profileModelData!.userData!.phone.toString();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultTextForm(
                    controller: nameController,
                    textInputType: TextInputType.text,
                    labelText: 'Name',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Name must not be empty';
                      }
                    },
                    borderRadius: 15,
                    contentPadding: 20,
                    borderColor: defaultColor,
                    labelColor: defaultColor,
                    preIcon: Icon(
                      Icons.person,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTextForm(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: 'Email Address',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Email Address must not be empty';
                      }
                    },
                    borderRadius: 15,
                    contentPadding: 20,
                    borderColor: defaultColor,
                    labelColor: defaultColor,
                    preIcon: Icon(
                      Icons.email_outlined,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTextForm(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    labelText: 'Phone Number',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Phone Number must not be empty';
                      }
                    },
                    borderRadius: 15,
                    contentPadding: 20,
                    borderColor: defaultColor,
                    labelColor: defaultColor,
                    preIcon: Icon(
                      Icons.phone,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTextForm(
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Password must not be empty';
                      }
                    },
                    borderRadius: 15,
                    contentPadding: 20,
                    borderColor: defaultColor,
                    labelColor: defaultColor,
                    preIcon: Icon(
                      Icons.lock,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      context: context,
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          HomeBloc.get(context).add(PutProfileDataEvent(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text));
                        }

                      },
                      text: 'UPDATE',
                      internalPadding: 20,
                      fontSize: 20),
                  SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      context: context,
                      onPressed: () {
                        CacheHelper.removeData(key: 'token').then((value) {
                          navigatorTo(context, LoginScreen());
                        });
                      },
                      text: 'LOGOUT',
                      internalPadding: 20,
                      fontSize: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
