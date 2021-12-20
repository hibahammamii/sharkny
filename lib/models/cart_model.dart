
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String? urlImage;
  int? itemID; // this for cart also
  String? sku;
  String? name;
  int? attributeSetId;
  int? status;
  int? qty; // not in all
  int? visibility;
  String? typeId;
  String? createdAt;
  String? updatedAt;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
     this.urlImage,
    this.status,this.name,this.updatedAt,this.typeId
  });
}
