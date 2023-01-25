import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/screens/address_detail_screen.dart';
import 'package:sharekny_app/screens/address_screen.dart';
import 'package:sharekny_app/screens/cart_screen.dart';
import 'package:sharekny_app/screens/home_screen.dart';
import 'package:sharekny_app/screens/log_in_screen.dart';
import 'package:sharekny_app/screens/my_profile_page.dart';
import 'package:sharekny_app/screens/orders_screen.dart';
import 'package:sharekny_app/screens/pay_out_screen.dart';
import 'package:sharekny_app/screens/product_detail_screen.dart';
import 'package:sharekny_app/screens/product_screen.dart';
import 'package:sharekny_app/screens/restore_email_screen.dart';
import 'package:sharekny_app/screens/search_screen.dart';
import 'package:sharekny_app/screens/sign_up_screen.dart';
import 'package:sharekny_app/screens/welcome_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  HomeScreen());
    case WelcomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) =>const LoginScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) =>SignUpScreen());
    case CartScreen.routeName:
      return MaterialPageRoute(builder: (context) =>CartScreen());
    case AddEmailScreen.routeName:
      return MaterialPageRoute(builder: (context) => AddEmailScreen());
    case AddressScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AddressScreen());
    case AddressDetailsScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AddressDetailsScreen());
    case SearchScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  SearchScreen());
    case PayOutsScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  PayOutsScreen());
    case MyProfile.routeName:
      return MaterialPageRoute(builder: (context) =>  MyProfile());
    // case OrdersScreen.routeName:
    //   return MaterialPageRoute(builder: (context) =>  OrdersScreen());
    case ProductDetailScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            loadedProduct:settings.arguments as Product,
          ));
    case ProductScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => ProductScreen(
            title:settings.arguments as String,
          ));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
