import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/providers/auth_provider.dart';
import 'package:sharekny_app/providers/cart_provider.dart';
import 'package:sharekny_app/providers/categories_provider.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/screens/home_screen.dart';
import 'package:sharekny_app/screens/welcome_screen.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:sharekny_app/services/prefrence.dart';
import 'package:sharekny_app/utilities/styles.dart';
import './utilities/router.dart' as router;

import 'models/wishlist_model.dart';
import 'utilities/get_it.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationProvider>(
          create: (_) => locator<LocalizationProvider>(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => locator<ProductsProvider>(),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (_) => locator<CategoriesProvider>(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => locator<CartProvider>(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => locator<AuthProvider>(),
        ),
        ChangeNotifierProvider<UserData>(
          create: (_) => locator<UserData>(),
        ),
        ChangeNotifierProvider<WishListModel>(
          create: (_) => locator<WishListModel>(),
        ),


      ],

      child: FutureBuilder<String>(
          future: Prefrence.getLanguageCode(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              locator<LocalizationProvider>().setLocal(snapshot.data);
            } else {
              locator<LocalizationProvider>().setLocal('en');
            }
            return Consumer<LocalizationProvider>(builder: (context, _, __) {
              return MaterialApp(
                theme:
                locator<LocalizationProvider>().locale!.languageCode == "en"
                    ? AppTextStyle.appTheme
                    : AppTextStyle.appThemeAr,
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
                navigatorKey: locator<NavigationServices>().navigatorKey,
                onGenerateRoute: router.generateRoute,
                supportedLocales: const [Locale('en'), Locale('ar')],
                locale:
                Provider.of<LocalizationProvider>(context).locale ?? const Locale('en'),
                localizationsDelegates: const [
                  // A class which loads the translations from JSON files
                  AppLocalizations.delegate,
                  // Built-in localization of basic text for Material widgets
                  GlobalMaterialLocalizations.delegate,
                  // Built-in localization for text direction LTR/RTL
                  GlobalWidgetsLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  // Check if the current device locale is supported
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale!.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                  // If the locale of the device is not supported, use the first one
                  // from the list (English, in this case).
                  return supportedLocales.first;
                },
              );
            });
          }),
    );
  }
}

