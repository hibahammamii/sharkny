import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/screens/home_screen.dart';
import 'package:sharekny_app/screens/log_in_screen.dart';
import 'package:sharekny_app/services/connectivity.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/services/prefrence.dart';
import 'package:sharekny_app/utilities/api.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

class AuthProvider with ChangeNotifier {
  bool isVendor = false;

  setIsVendor(bool isVendor) {
    this.isVendor = isVendor;
    ChangeNotifier();
  }

  bool getIsVendor() {
    return isVendor;
  }

  bool loading = false;
  bool updateLoading = false;

  setState() {


  }

  void logIn(BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey,
      {String? email, String? password}) async {
    // int counter = 0;
    clearData();
    setState();
    //var fcmToken = await Prefrence.getString(PrefKeys.FCM);
    // print(fcmToken);
    var response;
    try {
       response = await Api.instance.apiRequest(
          RequestType.Post,
          Uri.parse(
              'https://test.sharkny.net/api/auth/login?email=$email&password=$password')
       );
       if (response != null) {
         locator<UserData>().setCurrentUser = response['user'];
         locator<UserData>().currentUser!.token = response['access_token'];
         locator<UserData>().loggedIn = true;
         await Prefrence.setBool('loggedIn', true);

         await Prefrence.setString(
           PrefKeys.USER,
           jsonEncode(locator<UserData>().currentUser),
         );
         //logined

         //print(locator<CartProvider>().items.length);
         // if (locator<CartProvider>().items.length > 0) {

         /* if (counter == locator<CartProvider>().items.length)
          await locator<CartProvider>().getLoginedCart(firstLoad: true);*/
         // } else {
         //
         // }
         //}
         ScaffoldMessenger.of(context).hideCurrentSnackBar();
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             duration: const Duration(milliseconds: 800),
             backgroundColor: dangerColor,
             content: Text(
               AppLocalizations.of(context)!.translate("LogIn_successfully"),
               textAlign: TextAlign.start,
               style: const TextStyle(
                 color: Colors.white,
                 fontSize: 14.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
         );

         locator<NavigationServices>()
             .navigateToReplacmentUntil(HomeScreen.routeName);
         //
       } else {
         //danger color
         ScaffoldMessenger.of(context).hideCurrentSnackBar();
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             duration: const Duration(milliseconds: 800),
             backgroundColor: dangerColor,
             content: Text(
               AppLocalizations.of(context)!.translate("failed_login"),
               textAlign: TextAlign.start,
               style: const TextStyle(
                 color: Colors.white,
                 fontSize: 14.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
         );
       }
      // print(response);

      }
      catch (e) {
        print(e);
        return null;
    }


    loading = false;
    setState();
  }
  void signUp(
      BuildContext context,
      GlobalKey<ScaffoldState> _scaffoldKey, {
        String? name,
        String? email,
        String? password,
        String? cpassword,
        String? phone,
        String? linkName
      }) async {
    clearData();
    setState();
    await check().then((intenet) async {
      if (intenet != null && intenet) {
    var response = await Api.instance.apiRequest(
        RequestType.Post,Uri.parse('https://test.sharkny.net/api/auth/register?name=$name'
        '&email=$email&password=$password&password_confirmation=$cpassword'
        '&phone=$phone&link_name=$linkName')).timeout(const Duration(seconds: 20),onTimeout:noConnection(context));
    //print(response);
    if (response != null) {
      //here call show
      //sucess color
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: colorPrimary,
          content: Text(
            AppLocalizations.of(context)!.translate("register_successfully"),
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      logIn(context, _scaffoldKey, email: email, password: password);

      locator<NavigationServices>()
          .navigateToReplacmentUntil(HomeScreen.routeName);
    } else {
      //here call show
      //danger color
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 800),
          backgroundColor: dangerColor,
          content: Text(
            AppLocalizations.of(context)!.translate("failed_register"),
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    loading = false;
    setState();
  }
      else{
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 800),
            backgroundColor: dangerColor,
            content: Text(
              AppLocalizations.of(context)!.translate("check_internet_connections"),
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }

    });
    loading = false;
    setState();
  }




  clearData() {
    loading = true;
  }
  noConnection(context){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 800),
        backgroundColor: dangerColor,
        content: Text(
          AppLocalizations.of(context)!.translate("check_internet_connections"),
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    loading = false;
    setState();

  }
}