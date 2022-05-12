import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/constants.dart';


ThemeData lightTheme= ThemeData(
  primaryColor: defaultColor,
  primarySwatch: defaultColor,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: defaultColor,
  ),


  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(color: defaultColor)
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.grey[100],
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.deepOrange[100],
    elevation: 25,
  ),
);
ThemeData darkTheme= ThemeData();