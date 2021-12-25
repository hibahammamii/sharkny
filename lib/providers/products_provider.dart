import 'package:flutter/cupertino.dart';
import 'package:sharekny_app/models/product_model.dart';
import 'package:sharekny_app/utilities/api.dart';
import 'package:sharekny_app/utilities/constants.dart';

class ProductsProvider extends ChangeNotifier {
  String? categoryId;
  String? listingLocationId;
  String? categoryName;
  int? tagId;
  bool isFetching = false;

  //list products for products screen

  String? errMsg;
  bool? isEnd;
  List<Product> items = [];
  List<Product> topSales = [];
  List<Product> newArrival = [];
  List<dynamic> sliderImage=[];


  Future<Product?>? findById(int id) async {
    try {

      print(id);
      loadingProducts = true;
      var response = await Api.instance.apiRequest(RequestType.Get,Uri.parse(
          "${Constants.baseUrl}/api/products?product_id=$id"));
      loadingProducts = false;
      notifyListeners();

      return Product.fromJson(response);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void fetchProductsByCategory({categoryId, categoryName}) {
    this.categoryId = categoryId;
    this.categoryName = categoryName;
    notifyListeners();
  }

  bool loadingProducts = false;

  getProducts(int category) async {
    try {
      loadingProducts = true;
      var list = <Product>[];
      var response = await Api.instance.apiRequest(RequestType.Get,
          Uri.parse("${Constants.baseUrl}/api/products?category_id=$category"));
      print(response);
      if (response != null) {
        for (var item in response) {
          //if (item['slug'] != "uncategorized" && item['count'] > 0)

          list.add(Product.fromJson(item));
        }
        print(response);
        items = list;
        loadingProducts = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      rethrow;
    }

    loadingProducts = false;
    notifyListeners();
  }
getSliderImage() async{
    try
    {
      loadingProducts = true;
      var response = await Api.instance.apiRequest(
          RequestType.Get, Uri.parse("${Constants.baseUrl}/api/sliders"));
      if (response != null) {
        sliderImage = response;
        loadingProducts = false;
        notifyListeners();
        print("fffffffff");
        print(sliderImage);
      }
    } catch (e) {
      print(e);
      //rethrow;
    }

    loadingProducts = false;
    notifyListeners();
}
  getProductsTopSales() async {
    try {
      loadingProducts = true;

      var response = await Api.instance.apiRequest(
          RequestType.Get, Uri.parse("${Constants.baseUrl}/api/top_sales"));
      print(response);
      var list = <Product>[];

      if (response != null) {
        for (var item in response) {
          //if (item['slug'] != "uncategorized" && item['count'] > 0)
          {
            list.add(Product.fromJson(item));
          }
        }
        topSales = list;
        print(response);

        loadingProducts = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      //rethrow;
    }

    loadingProducts = false;
    notifyListeners();
  }

  getProductsNewArrival() async {
    try {
      loadingProducts = true;
      var list = <Product>[];

      var response = await Api.instance.apiRequest(
          RequestType.Get, Uri.parse("${Constants.baseUrl}/api/new_arrival"));

      if (response != null) {
        for (var item in response) {
          //if (item['slug'] != "uncategorized" && item['count'] > 0)
          {
            list.add(Product.fromJson(item));
          }
        }
        newArrival = list;

        loadingProducts = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      //rethrow;
    }

    loadingProducts = false;
    notifyListeners();
  }
}
