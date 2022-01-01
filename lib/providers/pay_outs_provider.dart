import 'package:flutter/cupertino.dart';
import 'package:sharekny_app/models/category_model.dart';
import 'package:sharekny_app/models/pay_outs_model.dart';
import 'package:sharekny_app/utilities/api.dart';
import 'package:sharekny_app/utilities/constants.dart';

class PayOutsProvider extends ChangeNotifier {
  PayOuts? payOuts ;
  bool loadingPayouts=false;

  Future<PayOuts?>? fetchPayOuts(int? id) async {
    try {
      loadingPayouts = true;
      var response = await Api.instance.apiRequest(RequestType.Get,Uri.parse(
          "${Constants.baseUrl}/api/payouts?user_id=1"));
      loadingPayouts = false;

      payOuts =PayOuts.fromJson(response);
      notifyListeners();
      print(response);


      return PayOuts.fromJson(response);
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
