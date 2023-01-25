import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/models/wishlist_model.dart';
import 'package:sharekny_app/providers/pay_outs_provider.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/services/prefrence.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  static const String routeName = 'SplashScreen';
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

   // loginCheck();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: Container(
              alignment: Alignment.center,

            )));
  }

  // loginCheck() async {
  //   navigation(HomeScreen.routeName);
  //   locator<UserData>().getUser();
  //   if(locator<UserData>().currentUser!.id != null) {
  //     await locator<WishListModel>().WishListOnline();
  //     await locator<PayOutsProvider>().fetchPayOuts(
  //         locator<UserData>().currentUser!.id);
  //   }
  // }

  navigation(var page) {
    Future.delayed(const Duration(milliseconds: 2000),
        () => locator<NavigationServices>().navigateToReplacment(page));
  }
}
