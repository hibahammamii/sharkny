import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharekny_app/screens/address_detail_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/styles.dart';


class AddressScreen extends StatelessWidget {
  static const routeName = "AddressScreen";

  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.appBar(context, "") as PreferredSizeWidget?,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  AppLocalizations.of(context)!.translate('address'),
                  style: AppTextStyle.mainTextStyle.copyWith(fontSize: 30),
                )),
            Container(
              height: 300,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      // decoration: const BoxDecoration(
                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                      //   // gradient: LinearGradient(
                      //   //   colors: [colorButtonBegin, colorButtonEnd],
                      //   //   begin: FractionalOffset.centerLeft,
                      //   //   end: FractionalOffset.centerRight,
                      //   // ),
                      // ),
                      child: GestureDetector(
                        onTap: () async {
                          locator<NavigationServices>()
                              .navigateTo(AddressDetailsScreen.routeName);
                        },
                        child: DottedBorder(
                          color: colorAccent, //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          dashPattern: [3, 6],
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("add_address"),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: colorAccent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Constants.buttonLinearGradient(
                      text: AppLocalizations.of(context)!.translate("continue"),
                      onTap: null,
                      width: double.infinity),
                  // Container(
                  //   width: double.infinity,
                  //   height: 50,
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     gradient: LinearGradient(
                  //       colors: [colorButtonBegin, colorButtonEnd],
                  //       begin: FractionalOffset.centerLeft,
                  //       end: FractionalOffset.centerRight,
                  //     ),
                  //   ),
                  //   child: const TextButton(
                  //     child: Text(
                  //       "continue",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     onPressed: null,
                  //   ),
                  // ),
                ),
              ],
            ),
          ]),
    );
  }
}
