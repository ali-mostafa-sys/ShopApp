import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/components/constants.dart';

void navigatorTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigatorReplace(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

Widget defaultTextForm(
        {required TextEditingController controller,
        required TextInputType textInputType,
        required String labelText,
        required var validate,
        var onTap,
        var suffixIcon,
        var preIcon,
        var onChange,
        bool obSecure = false,
        double contentPadding = 10,
        double borderRadius = 25,
        Color borderColor = Colors.deepOrange,
        Color labelColor = Colors.deepOrange}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: validate,
      onTap: onTap,
      onChanged: onChange,
      obscureText: obSecure,
      decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.all(contentPadding),
          labelText: labelText,
          labelStyle: TextStyle(color: labelColor),
          suffixIcon: suffixIcon,
          prefixIcon: preIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor))),
    );

Widget defaultButton({
  required context,
  required var onPressed,
  double borderRadiusOfButton = 25,
  double internalPadding = 10,
  Color fitColor = Colors.deepOrange,
  required String text,
  Color textColor = Colors.white,
  double fontSize = 10,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusOfButton),
          border: Border.all(width: 0, color: Colors.white)),
      child: MaterialButton(
        padding: EdgeInsets.all(internalPadding),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusOfButton),
            borderSide: BorderSide(width: 0)),
        minWidth: MediaQuery.of(context).size.width,
        color: fitColor,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );

Future defaultToast(
        {required String msg,
        ToastGravity toastGravity = ToastGravity.BOTTOM,
        required Color backgroundColor,
        required Color textColor,
        double textSize = 16}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: toastGravity,
        timeInSecForIosWeb: 5,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: textSize);


Widget defaultDivider(double width,Color color,double height)=>Container(
  width: width,
  color: color,
  height: height,
);