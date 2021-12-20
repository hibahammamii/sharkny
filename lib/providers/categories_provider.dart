import 'package:flutter/cupertino.dart';
import 'package:sharekny_app/models/category_model.dart';
import 'package:sharekny_app/utilities/api.dart';
import 'package:sharekny_app/utilities/constants.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoryModel> items = [];
 bool loadingCategory =false;

 getCategories() async {
    try {
      loadingCategory =true;
      var list = <CategoryModel>[];

      var response = await Api.instance.apiRequest(
          RequestType.Get,Uri.parse("${Constants.baseUrl}/api/categories"));

      if(response != null)
        {
          for (var item in response) {
            //if (item['slug'] != "uncategorized" && item['count'] > 0)
            {
              list.add(CategoryModel.fromJson(item));
            }
          }

        }
      items=list;
      loadingCategory =false;
      notifyListeners();




    }
     catch (e) {
      print(e);
      //rethrow;
    }


  }
  setCategories(jsonMap) {
    items = jsonMap != null && (jsonMap as List).length > 0
        ? List.from(jsonMap)
        .map((element) => CategoryModel.fromJson(element))
        .toList()
        : [];
    notifyListeners();
  }
}
