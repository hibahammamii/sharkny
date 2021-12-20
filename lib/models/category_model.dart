
import 'package:flutter/cupertino.dart';

class CategoryModel with ChangeNotifier{
  int? id;
  String? title;
  int? active;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  CategoryModel(this.id,this.title,this.active);

  CategoryModel.fromJson(dynamic json)
  {
    id = json["id"];
    title = json["title"];
    active = json["active"];
    // createdAt = json["created_at"];
    // updatedAt = json["updated_at"];
  }

  Map<String,dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["title"] = title;
    data["active"] = active;
    // data["created_at"] = createdAt;
    // data["updated_at"] = updatedAt;
    return data;
  }
}