
import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{
  int? id;
  int? userId;
  int? categoryId;
  String? title;
  int? price;
  String? storePrice;
  int? earn;
  String? desc;
  int? status;
  int? active;
  String? adminNotes;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? quantity;

  Product(this.id,this.userId,this.categoryId,this.title,this.price,this.storePrice,this.earn,this.desc,this.status,this.active,this.adminNotes,this.createdAt,this.updatedAt);

  Product.fromJson(dynamic json)
  {
    try{
    id = json["id"];
    userId = json["user_id"];
    categoryId = json["category_id"];
    title = json["title"].toString();
    price = json["price"];
    storePrice = json["store_price"];
    earn = json["earn"];
    desc = json["desc"].toString();
    status = json["status"];
    active = json["active"];
    image = json["pic"];
    quantity =json["qty"];
    adminNotes = json["admin_notes"].toString();
    createdAt = json["created_at"].toString();
    updatedAt = json["updated_at"].toString();}
  catch (e, trace) {
    print(trace);
    print(e.toString());
  }
  }

  Map<String,dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["user_id"] = userId;
    data["category_id"] = categoryId;
    data["title"] = title;
    data["price"] = price;
    data["store_price"] = storePrice;
    data["earn"] = earn;
    data["desc"] = desc;
    data["status"] = status;
    data["active"] = active;
    data["admin_notes"] = adminNotes;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["pic"] =image;
    data["qty"] = quantity;
    return data;
  }
}