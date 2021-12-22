import 'package:flutter/material.dart';

const colorButtonBegin = Color(0xFFED5F0D);
const colorButtonEnd = Color(0xFFf29a6a);
const subTextColor = Color(0xFF707070);
const colorPrimary = Color(0xFFF4F4F4);
const colorPrimaryDark = Color(0xFFfafafa);
const colorAccent = Color(0xFFFF7315);
const backgroundColor = Color(0xFFfafafa);
final Color successColor = Color(0xff34ac79);
final Color dangerColor = Color(0xfffd6864);
const whiteColor = Color(0xFFFFFFFF);
const blackColor = Color(0xFF232020);
const greenColor = Color(0xFF00C569);
const orangeColor = Color(0xFFFFC107);
const redColor = Color(0xFFfd314c);
const lightGrey = Color(0xFFDBDBDB);
const backgroundWhite = Color(0xffF8F8F8);
const mainTextColor = Color(0xFF1E1E1E);
const logoColor = Color(0xFF3A3535);


class AppTextStyle {
  static final appTheme = ThemeData(
      fontFamily: "SFPro",
      accentColor: colorAccent,
      primaryColor: colorPrimary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColorDark: colorPrimaryDark,
      brightness: Brightness.light,
      canvasColor: whiteColor,
      scaffoldBackgroundColor: backgroundColor);
  static final appThemeAr = ThemeData(
      fontFamily: "Cairo",
      accentColor: colorAccent,
      primaryColor: colorPrimary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColorDark: colorPrimaryDark,
      brightness: Brightness.light,
      canvasColor: whiteColor,
      scaffoldBackgroundColor: backgroundColor);
  static const mainTextStyle = TextStyle(
       fontSize: 18, color: blackColor);
  static const subTextStyle =
   TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: subTextColor);
}



class ButtonTextStyle {

  static final mainButtonStyle
  = ButtonStyle(backgroundColor: MaterialStateProperty.all(colorButtonBegin));


}