import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/models/user_model.dart';
import 'package:sharekny_app/utilities/api.dart';
import 'package:sharekny_app/utilities/constants.dart';
import 'package:sharekny_app/utilities/get_it.dart';


class WishListModel extends ChangeNotifier {
  WishListModel() {
    getLocalWishlist();
    WishListOnline();


  }

  List<Product?> products = [];
  List<int> wishListOnline=[];
  Future<void> WishListOnline()
  async {
    await locator<UserData>().getUser();
    try {

      var list = <int>[];


        var response = await Api.instance.apiRequest(
            RequestType.Get,
            Uri.parse("${Constants.baseUrl}/api/favorites?user_id=${locator<
                UserData>().currentUser!.id}"));
        print(response);

        if (response != null) {
          for (var item in response) {
            //if (item['slug'] != "uncategorized" && item['count'] > 0)
            {
              list.add(item["product_id"]);
            }
          }
        wishListOnline = list;
          notifyListeners();
      }

    }
    catch (e) {
      print(e);
      //rethrow;
    }

  }




  List<Product?> getWishList() => products;
  List<int?> getWishListOnline() => wishListOnline;

  Future<void> addToWishlist(Product? product,id) async {
    await Api.instance.apiRequest(
        RequestType.Post,
        Uri.parse(
            '${Constants.baseUrl}/api/fav?user_id=$id&action=add&product_id=${product!.id}')
    );
    notifyListeners();
    // final isExist = products.firstWhere((item) => item!.id == product!.id,
    //     orElse: () => null);
    // if (isExist == null) {
    //   products.add(product);
    //   saveWishlist(products);
    //   notifyListeners();
    // }
  }



  Future<void> removeToWishlist(Product? product,id) async {
    await Api.instance.apiRequest(
        RequestType.Post,
        Uri.parse(
            '${Constants.baseUrl}/api/fav?user_id=$id&action=remove&product_id=${product!.id}')
    );

    notifyListeners();
    // final isExist = products.firstWhere((item) => item!.id == product!.id,
    //     orElse: () => null);
    // if (isExist != null) {
    //   products = products.where((item) => item!.id != product!.id).toList();
    //   saveWishlist(products);
    //   notifyListeners();
    // }

  }

  Future<void> saveWishlist(List<Product?> products) async {
    final LocalStorage storage = LocalStorage("sharkny");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("wishlist", products);
      }
    } catch (_) {}
  }

  Future<void> getLocalWishlist() async {
    final LocalStorage storage = LocalStorage("sharkny");
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = await storage.getItem("wishlist");
        if (json != null) {
          List<Product> list = [];
          for (var item in json) {
            list.add(Product.fromJson(item));
          }
          products = list;
        }
      }
    } catch (_) {}
  }

  Future<void> clearWishList() async {
    products = [];
    await saveWishlist(products);
    notifyListeners();
  }
}
