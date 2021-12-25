import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/providers/cart_provider.dart';
import 'package:sharekny_app/providers/search_model.dart';
import 'package:sharekny_app/screens/cart_screen.dart';
import 'package:sharekny_app/screens/search_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/utilities/get_it.dart';
import 'package:sharekny_app/utilities/paths.dart';
import 'package:sharekny_app/utilities/styles.dart';
import 'package:sharekny_app/widgets/color_safe_area.dart';

class Constants {
  static const baseUrl = "https://test.sharkny.net";
  static const assetsIconsPath = "assets/icons/";
  static const assetsImagesPath = "assets/images/";
  static const assetsFilePath = "assets/files/";
  static const fontFamily = 'futur';
  static const apiKey = "AIzaSyA-u053-QWjtCckKQ28szGorc6GmfvIAyg";

  static const isDebug = true;

  static var greyShadow = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: .5,
        blurRadius: 20,
        offset: Offset(0, 8),
      ),
    ],
    borderRadius: BorderRadius.circular(15),
    color: Colors.white,
  );

  // static DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  //
  // static Widget loadingElement({Color color}) {
  //   return Center(
  //     child: CircularProgressIndicator(
  //       strokeWidth: 1,
  //       valueColor: AlwaysStoppedAnimation<Color>(color ?? colorAccent),
  //     ),
  //   );
  // }

  static Widget appBar(BuildContext context, String key,
      {Color? iconColor,
      Function? onTap,
      IconData? icon,
      Function? onPressed,
      Widget? action}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(AppLocalizations.of(context)!.translate(key)),
      centerTitle: true,
      leading: InkWell(
          onTap: () {
            if (onTap == null) {
              locator<NavigationServices>().goBack();
              return;
            }
            onTap();
          },
          child: locator<LocalizationProvider>().locale!.languageCode == "en"
              ? Image.asset(
                  "assets/icons/arrow_left.png",
                  color: iconColor ?? Colors.grey,
                )
              : Image.asset(
                  "assets/icons/arrow_right.png",
                  color: iconColor ?? lightGrey,
                )),

      actions: [
      if(action != null)
        action,
      ],
    );
  }

  static Widget buttonLinearGradient(
      {String? text, Function? onTap, Key? key, double? width}) {
    return Container(
      width: width ?? 200,
      height: 50,
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
          text!,
          style: AppTextStyle.subTextStyle
              .copyWith(color: whiteColor, fontWeight: FontWeight.w800),
        ),
        onPressed: () {
          if (onTap == null) {
            locator<NavigationServices>().goBack();
            return;
          }
          onTap();
        },
      ),
    );
  }

  static Future<bool> onPop(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Text(
            AppLocalizations.of(context)!.translate('exit_app'),
            // style: AppTextStyle.labels,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
              child: Text(AppLocalizations.of(context)!.translate('ok')),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: colorButtonBegin),
              child: Text(AppLocalizations.of(context)!.translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
    return true;
  }

  static Widget loadingElement({Color? color}) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? colorAccent),
      ),
    );
  }

//
  static int retrieveIndex(List<int> dim, List<int> indexs) {
    int index = 1;
    int result = 0;
    //
    int indexLength = indexs.length;
    int dimLength = dim.length;
    //
    for (int i = 0; i < indexLength; i++) {
      for (int j = 1; j < dimLength; j++) {
        index *= dim[j];
      }
      result += index * indexs[i];
      index = 1;
      dimLength -= 1;
    }
    return result;
  }

  /* if (dim.length == 2) {
      index = dim[1] * indexs[0] + indexs[1];
    }
    //
    else if (dim.length == 3) {
      index =
          (dim[1] * dim[2] * indexs[0]) + (dim[1] * indexs[1]) + (indexs[2]);
    }
    //
    else if (dim.length == 4) {
      index = (dim[1] * dim[2] * dim[3] * indexs[0]) +
          (dim[1] * dim[2] * indexs[1]) +
          (dim[1] * indexs[2]) +
          (indexs[3]);
    }
    //
    else if (dim.length == 5) {
      index = (dim[1] * dim[2] * dim[3] * dim[4] * indexs[0]) +
          (dim[1] * dim[2] * dim[3] * indexs[1]) +
          (dim[1] * dim[2] * indexs[2]) +
          (dim[1] * indexs[3]) +
          (indexs[4]);
    }*/
  //return index;

//
  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
    }));
    return list;
  }

  static validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // ignore: unnecessary_new
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Email is invalid";
    } else {
      return null;
    }
  }

  static Color fromHex(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));

      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Colors.black;
    }
  }

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;

  const HomeAppBar({Key? key, this.onTap})
      : preferredSize = const Size.fromHeight(105.0);

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.dark;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)),
          color: whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 35, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                  builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Image.asset(
                        "assets/icons/Menu_bar.png",
                        color: logoColor,
                      ))),
              Container(
                child: Image.asset(
                  "assets/images/logo01-light.png",
                  height: 50,
                ),
                color: whiteColor,
              ),
              Row(
                children: [
                  InkWell(
                    onTap:  () => locator<NavigationServices>()
        .navigateTo(CartScreen.routeName),
                    child: Badge(
                        badgeContent: Consumer<CartProvider>(
                          builder: (_, data, __) {
                            return Text(
                              data.itemCount.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .apply(color: Colors.white),
                            );
                          },
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: logoColor,
                        ),
                        position: BadgePosition.topStart(start: -9, top: -13)
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        locator<SearchModel>().clearData();
                        locator<NavigationServices>()
                          .navigateTo(SearchScreen.routeName);},
                      icon: const Icon(
                        Icons.search,
                        color: logoColor,
                      )),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  final Size preferredSize;
}
