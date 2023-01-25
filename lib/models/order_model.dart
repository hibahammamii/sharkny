// class Orders {
//  List<OrdersList>? ordersList;
//   int? requested;
//   int? approved;
//   int? shipped;
//   int? delivered;
//   int? rejected;
//   int? returned;
//   int? cancelled;
//   int? returnedToStock;
//   int? np;
//
//   Orders(this.ordersList,this.requested,this.approved,this.shipped,this.delivered,this.rejected,this.returned,this.cancelled,this.returnedToStock,this.np);
//
//   Orders.fromJson(dynamic json)
//   {
//
//     if(json['orders'] != null )
//     {
//       List<OrdersList>
//       ordersList=[];
//       json['orders'].forEach((item){
//         ordersList.add(OrdersList.fromJson(item));
//       }
//       );
//       this.ordersList = ordersList;
//
//     }
//     requested = json["requested"];
//     approved = json["approved"];
//     shipped = json["shipped"];
//     delivered = json["delivered"];
//     rejected = json["rejected"];
//     returned = json["returned"];
//     cancelled = json["cancelled"];
//     returnedToStock = json["returned_to_stock"];
//     np = json["np"];
//   }
//
//   Map<String,dynamic> toJson()
//   {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["orders"] = ordersList;
//     data["requested"] = requested;
//     data["approved"] = approved;
//     data["shipped"] = shipped;
//     data["delivered"] = delivered;
//     data["rejected"] = rejected;
//     data["returned"] = returned;
//     data["cancelled"] = cancelled;
//     data["returned_to_stock"] = returnedToStock;
//     data["np"] = np;
//     return data;
//   }
// }
// class OrdersList {
//   int? id;
//   int? userId;
//   String? name;
//   String? phone;
//   int? stateId;
//   String? state;
//   int? areaId;
//   String? area;
//   String? address;
//   String? addressNotes;
//   String? notes;
//   int? statues;
//   String? statusDate;
//   String? trackingNumber;
//   String? trackingStatus;
//   String? adminNotes;
//   String? createdAt;
//   int? createdBy;
//   String? updatedAt;
//   String? updatedBy;
//   List<OrdersSeller>? seller;
//   List<OrdersProducts>? products;
//
//   OrdersList(this.id,this.userId,this.name,this.phone,this.stateId,this.state,this.areaId,this.area,this.address,this.addressNotes,this.notes,this.statues,this.statusDate,this.trackingNumber,this.trackingStatus,this.adminNotes,this.createdAt,this.createdBy,this.updatedAt,this.updatedBy,this.seller,this.products);
//
//   OrdersList.fromJson(dynamic json)
//   {
//     id = json["id"];
//     userId = json["user_id"];
//     name = json["name"];
//     phone = json["phone"];
//     stateId = json["state_id"];
//     state = json["state"];
//     areaId = json["area_id"];
//     area = json["area"];
//     address = json["address"];
//     addressNotes = json["address_notes"];
//     notes = json["notes"];
//     statues = json["statues"];
//     statusDate = json["status_date"];
//     trackingNumber = json["tracking_number"];
//     trackingStatus = json["tracking_status"];
//     adminNotes = json["admin_notes"];
//     createdAt = json["created_at"];
//     createdBy = json["created_by"];
//     updatedAt = json["updated_at"];
//     updatedBy = json["updated_by"];
//
//     if(json['seller'] != null)
//     {
//       List<OrdersSeller>
//       ordersSeller=[];
//       json['seller'].forEach((item){
//         ordersSeller.add(OrdersSeller.fromJson(item));
//       }
//       );
//      seller = ordersSeller;
//
//     }
//
//     if(json['products'] != null)
//     {
//       List<OrdersProducts>
//       ordersProducts=[];
//       json['products'].forEach((item){
//         ordersProducts.add(OrdersProducts.fromJson(item));
//       }
//       );
//       products = ordersProducts;
//
//     }
//   }
//
//   Map<String,dynamic> toJson()
//   {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["id"] = id;
//     data["user_id"] = userId;
//     data["name"] = name;
//     data["phone"] = phone;
//     data["state_id"] = stateId;
//     data["state"] = state;
//     data["area_id"] = areaId;
//     data["area"] = area;
//     data["address"] = address;
//     data["address_notes"] = addressNotes;
//     data["notes"] = notes;
//     data["statues"] = statues;
//     data["status_date"] = statusDate;
//     data["tracking_number"] = trackingNumber;
//     data["tracking_status"] = trackingStatus;
//     data["admin_notes"] = adminNotes;
//     data["created_at"] = createdAt;
//     data["created_by"] = createdBy;
//     data["updated_at"] = updatedAt;
//     data["updated_by"] = updatedBy;
//     data["seller"] = seller;
//     data["products"] = products;
//     return data;
//   }
// }
// class OrdersProducts {
//   int? id;
//   int? orderId;
//   int? productId;
//   int? count;
//   int? customPrice;
//   int? price;
//   int? earn;
//   String? createdAt;
//   String? updatedAt;
//   OrdersProductsDetails? details;
//
//   OrdersProducts(this.id,this.orderId,this.productId,this.count,this.customPrice,this.price,this.earn,this.createdAt,this.updatedAt,this.details);
//
//   OrdersProducts.fromJson(dynamic json)
//   {
//     id = json["id"];
//     orderId = json["order_id"];
//     productId = json["product_id"];
//     count = json["count"];
//     customPrice = json["custom_price"];
//     price = json["price"];
//     earn = json["earn"];
//     createdAt = json["created_at"];
//     updatedAt = json["updated_at"];
//     if(json["details"] != null) {
//       details = OrdersProductsDetails.fromJson(json["details"]);
//     }
//   }
//
//   Map<String,dynamic> toJson()
//   {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["id"] = id;
//     data["order_id"] = orderId;
//     data["product_id"] = productId;
//     data["count"] = count;
//     data["custom_price"] = customPrice;
//     data["price"] = price;
//     data["earn"] = earn;
//     data["created_at"] = createdAt;
//     data["updated_at"] = updatedAt;
//     data["details"] = details;
//     return data;
//   }
// }
// class OrdersProductsDetails {
//   int? id;
//   String? userId;
//   int? categoryId;
//   String? title;
//   int? price;
//   String? storePrice;
//   int? earn;
//   String? desc;
//   int? shippingRate;
//   String? finalPrice;
//   String? adminCommission;
//   String? status;
//   int? active;
//   String? adminNotes;
//   String? createdAt;
//   String? updatedAt;
//
//   OrdersProductsDetails(this.id,this.userId,this.categoryId,this.title,this.price,this.storePrice,this.earn,this.desc,this.shippingRate,this.finalPrice,this.adminCommission,this.status,this.active,this.adminNotes,this.createdAt,this.updatedAt);
//
//   OrdersProductsDetails.fromJson(dynamic json)
//   {
//     id = json["id"];
//     userId = json["user_id"];
//     categoryId = json["category_id"];
//     title = json["title"];
//     price = json["price"];
//     storePrice = json["store_price"];
//     earn = json["earn"];
//     desc = json["desc"];
//     shippingRate = json["shipping_rate"];
//     finalPrice = json["final_price"];
//     adminCommission = json["admin_commission"];
//     status = json["status"];
//     active = json["active"];
//     adminNotes = json["admin_notes"];
//     createdAt = json["created_at"];
//     updatedAt = json["updated_at"];
//   }
//
//   Map<String,dynamic> toJson()
//   {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["id"] = id;
//     data["user_id"] = userId;
//     data["category_id"] = categoryId;
//     data["title"] = title;
//     data["price"] = price;
//     data["store_price"] = storePrice;
//     data["earn"] = earn;
//     data["desc"] = desc;
//     data["shipping_rate"] = shippingRate;
//     data["final_price"] = finalPrice;
//     data["admin_commission"] = adminCommission;
//     data["status"] = status;
//     data["active"] = active;
//     data["admin_notes"] = adminNotes;
//     data["created_at"] = createdAt;
//     data["updated_at"] = updatedAt;
//     return data;
//   }
// }
// class OrdersSeller {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//
//   OrdersSeller(this.id,this.name,this.email,this.phone);
//
//   OrdersSeller.fromJson(dynamic json)
//   {
//     id = json["id"];
//     name = json["name"];
//     email = json["email"];
//     phone = json["phone"];
//   }
//
//   Map<String,dynamic> toJson()
//   {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["id"] = id;
//     data["name"] = name;
//     data["email"] = email;
//     data["phone"] = phone;
//     return data;
//   }
// }