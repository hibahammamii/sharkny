import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/providers/auth_provider.dart';
import 'package:sharekny_app/screens/sign_up_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';


import 'log_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = "WelComeScreen";
   WelcomeScreen({Key? key}) : super(key: key);
  final auth = locator<AuthProvider>();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(

              children: [
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 30.0, bottom: 8),
                      child: Text(
                        'Welcome to App ',
                        style: TextStyle(
                            fontSize: 18,
                            color: subTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('Explore as',
                        style: TextStyle(
                          fontSize: 16,
                          color: subTextColor,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 95),
                  child: SizedBox(
                      height: height * 0.4,
                      child: SvgPicture.asset("assets/images/welcome_image.svg")),
                ),
                Column(
                  children: [
                    Container(

                      width: width * 0.5,
                      height: height * 0.07,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                          colors: [colorButtonBegin, colorButtonEnd],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.translate('sign_in'),
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: () => locator<NavigationServices>()
                            .navigateTo(LoginScreen.routeName),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: InkWell(
                          onTap: () {
                            auth.setIsVendor(false);
                            locator<NavigationServices>()
                              .navigateTo(SignUpScreen.routeName);},
                          child: Text(
                            AppLocalizations.of(context)!.translate('sign_up'),
                            style: const TextStyle(color: Colors.black),
                          )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 40,top: 6),
                    //   child: InkWell(
                    //     onTap: () {
                    //       auth.setIsVendor(true);
                    //       locator<NavigationServices>()
                    //           .navigateTo(SignUpScreen.routeName);},
                    //     child: Text(
                    //       AppLocalizations.of(context)!
                    //           .translate('sign_up_vendor'),
                    //       style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    //     ),
                    //   ),
                    // )

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
