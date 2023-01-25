import 'package:get_it/get_it.dart';
import 'package:sharekny_app/models/cart_model.dart';
import 'package:sharekny_app/models/category_model.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/models/wishlist_model.dart';
import 'package:sharekny_app/providers/auth_provider.dart';
import 'package:sharekny_app/providers/cart_provider.dart';
import 'package:sharekny_app/providers/categories_provider.dart';
import 'package:sharekny_app/providers/orders_provider.dart';
import 'package:sharekny_app/providers/pay_outs_provider.dart';
import 'package:sharekny_app/providers/products_provider.dart';
import 'package:sharekny_app/providers/search_model.dart';
import 'package:sharekny_app/services/localization/app_localization.dart';
import 'package:sharekny_app/services/navigation_services.dart';
import 'package:logger/logger.dart';


class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  void log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    println(color!('$emoji $className - ${event.message}'));
  }
}

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationServices());
  locator.registerLazySingleton(() => LocalizationProvider());
  locator.registerLazySingleton(() => ProductsProvider());
  locator.registerLazySingleton(() => CategoriesProvider());
  locator.registerLazySingleton(() => CartProvider());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => UserData());
  locator.registerLazySingleton(() => WishListModel());
  locator.registerLazySingleton(() => SearchModel());
  locator.registerLazySingleton(() => PayOutsProvider());
  //locator.registerLazySingleton(() => OrdersProvider());



}
