import 'package:flutter/cupertino.dart';

class NavigationServices {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithArg(String routeName, dynamic arg) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arg);
  }

  Future<dynamic> navigateToReplacment(String routeName, {dynamic arg}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arg);
  }

  Future<dynamic> navigateToReplacmentUntil(String routeName, {dynamic arg}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route route) => false,
        arguments: arg);
  }

  /* Future<bool> popUntilMethod() {
    // Constants.selectedDrawerIndex = 0;
    // navigatorKey.currentState.pushNamedAndRemoveUntil(
    // MainMushafScreen.Route_Name, (Route route) => false);
  }*/

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
