import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/utilities/api.dart';
import 'package:sharekny_app/utilities/constants.dart';


class SearchModel extends ChangeNotifier {
  // final String langCode;

  bool loadingProducts = false;

  List<String> keywords = [];
  List<Product> _products = [];
  int _page = 1;
  bool _isEnd = false;
  String _currentName = '';

//  bool _isLoading = false;

  var category = '';


  bool isLoading = false;
  String errMsg= "";

  bool get isEnd => _isEnd;



  List<Product> get products => _products;
  clearData(){
    _products=[];
    notifyListeners();
  }

  Future<void> loadProduct({String? name, bool hasFilter = false}) async {
    if (name != _currentName || hasFilter) {
      _currentName = name!;
      _page = 1;
      _products = [];
      _isEnd = false;
    } else {
      _page++;
    }

    if (!hasFilter) {
      if (_isEnd) return;

      // if (isLoading) return;
    }

    isLoading = true;
    notifyListeners();

    var newProducts = await searchProducts(
      name: name,
    );
    //
    // if (newProducts == null || newProducts.isEmpty) {
    //   if (products?.isEmpty ?? true) {
    //     _products = <Product>[];
    //   }
    //   isLoading = false;
    //   _isEnd = true;
    //   notifyListeners();
    //   return;
    // }

    if (products == null) _products = <Product>[];

    products.addAll(newProducts);

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    _page = 1;
    _products = <Product>[];
    await loadProduct();
  }

  void refreshProduct(List<Product> product) {
    _products = product;
    notifyListeners();
  }

  // void searchByFilter(
  //     Map<String, List<dynamic>> searchFilterResult, String searchText) {
  //   if (searchFilterResult.isEmpty) clearFilter();
  //
  //   searchFilterResult.forEach((key, value) {
  //     switch (key) {
  //       case 'cars':
  //         type = value.isNotEmpty ? '${value.first.name}' : '';
  //         break;
  //       case 'carsModels':
  //         model = value.isNotEmpty ? '${value.first.mark}' : '';
  //         break;
  //       case 'years':
  //         year = value.isNotEmpty ? '${value.first}' : '';
  //         break;
  //       case 'city':
  //         city = value.isNotEmpty ? '${value.first}' : '';
  //         break;
  //
  //       default:
  //         attribute = key;
  //         attribute_term = value.isNotEmpty ? '${value.first.id}' : '';
  //     }
  //   });
  //
  //   // loadProduct(
  //   //   name: searchText.isEmpty ? '' : searchText,
  //   //   hasFilter: true,
  //   // );
  // }
  //
  // void clearFilter() {
  //   category = '';
  //   tag = '';
  //   attribute = '';
  //   attribute_term = '';
  //   type = '';
  //   model = '';
  //   year ='';
  //   city ='';
  // }

  Future<List<Product>> searchProducts({
    String? name,
    int? categoryID,

  }) async {
    try {
      String endPoint =  "${Constants.baseUrl}/api/search?";
      if(categoryID != null)
        {
          endPoint += "category_id=$categoryID";
        }
      if(name != null)
      {
        endPoint += "name=$name";
      }
       loadingProducts = true;
      var list = <Product>[];
      final data = await Api.instance.apiRequest(
          RequestType.Get,Uri.parse(endPoint));
      if (data != null) {
        for (var item in data) {
          //if (item['slug'] != "uncategorized" && item['count'] > 0)

          list.add(Product.fromJson(item));
        }
      }
        print(data);
        _products = list;
        loadingProducts = false;
        notifyListeners();

      // if (data.isNotEmpty && name!.isNotEmpty) {
      //   int index = keywords.indexOf(name);
      //   if (index > -1) {
      //     keywords.removeAt(index);
      //   }
      //   keywords.insert(0, name);
      //   await saveKeywords(keywords);
      // }
      errMsg = "";
      return products;
    } catch (err) {
      isLoading = false;
      errMsg = "⚠️ " + err.toString();
      notifyListeners();
      return <Product>[];
    }
  }

  void clearKeywords() {
    keywords = [];
   // saveKeywords(keywords);
    notifyListeners();
  }

  // Future<void> saveKeywords(List<String> keywords) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setStringList(kLocalKey["recentSearches"], keywords);
  //   } catch (_) {}
  // }
  //
  // Future<void> getKeywords() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final list = prefs.getStringList(kLocalKey["recentSearches"]);
  //     if (list != null && list.isNotEmpty) {
  //       keywords = list;
  //       notifyListeners();
  //     }
  //   } catch (_) {}
  // }
  //
  // searchListingProducts({String name, page}) async {
  //   _products.clear();
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     _products = await Services().searchProducts(name: name, page: page);
  //
  //     isLoading = false;
  //     errMsg = null;
  //     notifyListeners();
  //   } catch (err) {
  //     isLoading = false;
  //     errMsg =
  //         "يرجى إعادة المحاولة ....";
  //     notifyListeners();
  //   }
  //   return _products;
  // }
}
