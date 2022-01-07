import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Constant {
  static Color scaffoldBgColor = Color(0xFFFAF9F7);
  static Color greyColor = Colors.grey;
 static Color primaryColor = Color.fromARGB(255, 29, 68, 184);
 static Color secondaryColor = Color.fromARGB(255, 255, 0, 0);
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color lightPrimaryColor = primaryColor.withOpacity(0.2);
  static Color darkBlueColor = Color(0xFF151C48);
  static double fixPadding = 10.0;
  static Widget bzLoaderDefault = SpinKitCircle(size: 25, color: primaryColor,);

  static Widget bzLoaderWhite = SpinKitCircle(size: 25, color: Colors.white,);

  static SizedBox widthSpace = SizedBox(width: 10.0);

  static SizedBox heightSpace = SizedBox(height: 10.0);

  static TextStyle appBarLocationTextStyle = TextStyle(
    color: blackColor,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle appBarTitleTextStyle = TextStyle(
    color: blackColor,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appBarWhiteTitleTextStyle = TextStyle(
    color: whiteColor,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

// Grey Color TextStyle

  static  TextStyle greySearchTextStyle = TextStyle(
    color: greyColor,
    fontSize: 16.0,
  );

// Black Color TextStyle

  static TextStyle blackBigBoldTextStyle = TextStyle(
    color: blackColor,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle blackHeadingTextStyle = TextStyle(
    color: blackColor,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle blackNormalBoldTextStyle = TextStyle(
    color: blackColor,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle blackNormalTextStyle = TextStyle(
    color: blackColor,
    fontSize: 15.0,
  );

  static TextStyle blackColorButtonTextStyle = TextStyle(
    fontSize: 18.0,
    color: blackColor,
    fontWeight: FontWeight.w500,
  );

  static  TextStyle blackSmallBoldTextStyle = TextStyle(
    color: blackColor,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle blackSmallTextStyle = TextStyle(
    color: blackColor,
    fontSize: 12.0,
  );

// White Color TextStyle

  static TextStyle whiteColorHeadingTextStyle = TextStyle(
    color: whiteColor,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteColorNormalTextStyle = TextStyle(
    color: whiteColor,
    fontSize: 15.0,
  );

  static TextStyle whiteColorNormalBoldTextStyle = TextStyle(
    color: whiteColor,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteColorSmallTextStyle = TextStyle(
    color: whiteColor,
    fontSize: 13.0,
  );

  static TextStyle whiteColorSmallBoldTextStyle = TextStyle(
    color: whiteColor,
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteColorButtonTextStyle = TextStyle(
    fontSize: 18.0,
    color: whiteColor,
    fontWeight: FontWeight.w500,
  );

// Primary Color TextStyle

  static TextStyle primaryColorHeadingTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle primaryColorNormalBoldTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle primaryColorNormalTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 15.0,
  );

  static TextStyle primaryColorsmallTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 12.0,
  );

  TextStyle primaryColorsmallBoldTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle primaryColorButtonTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

// Grey Color TextStyle

  static TextStyle greyNormalTextStyle = TextStyle(
    color: greyColor,
    fontSize: 15.0,
  );

  static TextStyle greySmallBoldTextStyle = TextStyle(
    color: greyColor,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle greySmallTextStyle = TextStyle(
    color: greyColor,
    fontSize: 12.0,
  );

// Orange Color TextStyle

  static TextStyle orangeButtonBoldTextStyle = TextStyle(
    color: Colors.orange,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

// Green Color TextStyle

  static TextStyle greenColorNormalTextStyle = TextStyle(
    color: Colors.green,
    fontSize: 15.0,
  );

// red Color TextStyle

  static TextStyle redColorNormalTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 15.0,
  );

// Login Signup Text Style

  static TextStyle loginBigTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle whiteSmallLoginTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle blackSmallLoginTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle inputLoginTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle inputOtpTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );

}