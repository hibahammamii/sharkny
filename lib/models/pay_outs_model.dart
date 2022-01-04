import 'package:flutter/cupertino.dart';

class PayOuts with ChangeNotifier {
  int? ordersCount;
  int? successOrdersCount;
  int? balance;
  int? availablebalance;
  int? totalEarn;
  List<ListPayOuts>? listPayOuts;

  PayOuts(this.ordersCount,this.successOrdersCount,this.balance,this.availablebalance,this.totalEarn,this.listPayOuts);

  PayOuts.fromJson(dynamic json)
  {
    ordersCount = json["ordersCount"];
    successOrdersCount = json["successOrdersCount"];
    balance = json["balance"];
    availablebalance = json["availablebalance"];
    totalEarn = json["totalEarn"];
  if(json['list'] != null )
    {
    List<ListPayOuts>
    listPayOuts=[];
    json['list'].forEach((item){
    listPayOuts.add(ListPayOuts.fromJson(item));
    }
    );
    this.listPayOuts = listPayOuts;

    }
  print(json['list'] );
  }

  Map<String,dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ordersCount"] = ordersCount;
    data["successOrdersCount"] = successOrdersCount;
    data["balance"] = balance;
    data["availablebalance"] = availablebalance;
    data["totalEarn"] = totalEarn;
    data["list"] = listPayOuts;
    return data;
  }
}
class ListPayOuts {
  int? id;
  int? userId;
  int? amount;
  int? type;
  String? target;
  String? notes;
  int? statues;
  String? createdAt;
  String? updatedAt;

  ListPayOuts(this.id,this.userId,this.amount,this.type,this.target,this.notes,this.statues,this.createdAt,this.updatedAt);

  ListPayOuts.fromJson(dynamic json)
  {
    id = json["id"];
    userId = json["user_id"];
    amount = json["amount"];
    type = json["type"];
    target = json["target"];
    notes = json["notes"];
    statues = json["statues"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String,dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["user_id"] = userId;
    data["amount"] = amount;
    data["type"] = type;
    data["target"] = target;
    data["notes"] = notes;
    data["statues"] = statues;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}