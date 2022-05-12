import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_bloc.dart';
import 'package:shop_app/layout/home_layout/home_bloc/home_events.dart';
import 'package:shop_app/layout/home_layout/home_layout.dart';
import 'package:shop_app/moduls/login/shop_login_screen.dart';
import 'package:shop_app/moduls/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper/cache_halper.dart';
import 'package:shop_app/shared/network/remot/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:toast/toast.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  HttpOverrides.global = new MyHttpOverrides();
  await CacheHelper.init();
 late Widget widgets;

  bool? onBoarding=await CacheHelper.getBoolData(key: 'onBoarding');
   token=await CacheHelper.getStringData(key: 'token')??'';

  if(onBoarding!=null){

    if(token!=null){
      widgets=HomeLayout();
    }else{
      widgets=LoginScreen() ;
    }
  }else{
    widgets=OnBoardingScreen();
  }

  runApp( MyApp(widgets: widgets,));
}

class MyApp extends StatelessWidget {

  Widget widgets;

  MyApp({required this.widgets});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> HomeBloc()..add(OneOpenPage())..add(GetCategories())..add(GetProfileDataEvent())),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        home: widgets,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



