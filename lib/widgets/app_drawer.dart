import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/screens/cart_screen.dart';
import 'package:sharekny_app/screens/home_screen.dart';
import 'package:sharekny_app/screens/log_in_screen.dart';
import 'package:sharekny_app/screens/my_profile_page.dart';
import 'package:sharekny_app/screens/welcome_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {


  @override
  void initState() {
    super.initState();
    locator<UserData>().getUser();

  }

  @override
  Widget build(BuildContext context) {



    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
              onPressed: () => locator<NavigationServices>()
                  .navigateToReplacment(HomeScreen.routeName),
              child: Text(AppLocalizations.of(context)!.translate('home'),
                  style: AppTextStyle.subTextStyle.copyWith(fontSize: 20))),
          TextButton(

              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                bool? loggedIn = await prefs.getBool('loggedIn') ?? false;
                if(!loggedIn) {
                locator<NavigationServices>()
                  .navigateTo(WelcomeScreen.routeName);
              }
              else
                {
                  locator<NavigationServices>()
                      .navigateTo(MyProfile.routeName);

                }

              },
              child: Text(AppLocalizations.of(context)!.translate('my_profile'),
                  style: AppTextStyle.subTextStyle.copyWith(fontSize: 20))),
          TextButton(
              onPressed: () => locator<NavigationServices>()
        .navigateTo(CartScreen.routeName),
              child: Text(AppLocalizations.of(context)!.translate('cart'),
                  style: AppTextStyle.subTextStyle.copyWith(fontSize: 20))),
          TextButton(
              onPressed: null,
              child: Text(AppLocalizations.of(context)!.translate('orders'),
                  style: AppTextStyle.subTextStyle.copyWith(fontSize: 20))),
          TextButton(
              onPressed:null,
              child: Text(AppLocalizations.of(context)!.translate('pay_out'),
                  style: AppTextStyle.subTextStyle.copyWith(fontSize: 20))),
          TextButton(
              onPressed: () {
                showAlertDialog(context);
              },
              child: Text(
                  AppLocalizations.of(context)!.translate('change_lang'),
                  style: AppTextStyle.subTextStyle.copyWith(fontSize: 20))),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.translate("cancel"),
        style: const TextStyle(color: Colors.black),
      ), //"Cancel"
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.translate("confirm"),
        style: const TextStyle(color: colorAccent),
      ),
      onPressed: () async {
        Navigator.pop(context);
        locator<LocalizationProvider>().changeLanguage(
            locator<LocalizationProvider>().locale!.languageCode == "en"
                ? "ar"
                : "en");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.translate("change_lang")),
      content:
          Text(AppLocalizations.of(context)!.translate("change_lang_content")),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
