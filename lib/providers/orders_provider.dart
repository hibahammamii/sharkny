import 'package:flutter/cupertino.dart';
import 'package:sharekny_app/models/order_model.dart';
import 'package:sharekny_app/utilities/api.dart';
import 'package:sharekny_app/utilities/constants.dart';

class OrdersProvider extends ChangeNotifier {
  Orders? orders ;
  bool loadingOrders=false;

  Future<Orders?>? fetchOrders(int? id) async {
    try {
      loadingOrders = true;
      var response = await Api.instance.apiRequest(RequestType.Get,Uri.parse(
          "${Constants.baseUrl}/api/orders?user_id=1"));
      loadingOrders = false;

      orders =Orders.fromJson(response);
      notifyListeners();
      print(response);
      return Orders.fromJson(response);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
// setCategories(jsonMap) {
//   items = jsonMap != null && (jsonMap as List).length > 0
//       ? List.from(jsonMap)
//       .map((element) => CategoryModel.fromJson(element))
//       .toList()
//       : [];
//   notifyListeners();
// }
}
