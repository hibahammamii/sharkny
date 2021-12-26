import 'package:flutter/cupertino.dart';
import 'package:sharekny_app/models/cart_model.dart';
import 'package:sharekny_app/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  // bool applyResponse = false;
  String concateSkus = "";
  bool loading = false;
  bool getLoading = false;
  bool totalLoading = false;
  bool coupanLoading = false;
  bool deleteLoading = false;
  final Map<String, int> productsInCart = {};

  //List<Product> items = [];
  List<Product> itemDetails = [];
  Map<String, CartItem> _items = {};
  int get totalCartQuantity =>
      productsInCart.values.fold(0, (v, e) => v + e);

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }
  double getProductPrice(id) {
    double total = 0;
   total = productsInCart[id]!  * _items[id]!.price;
   return total;

}



  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity!;
    });
    return total;

  }
  changeQty(id,qty)
  {
    _items[id]!.quantity = qty;
    notifyListeners();

  }


  void addItem(
      int productId,
      double price,
      String title,
      String? urlImage,
      int quantity
      ) {
    if (_items.containsKey(productId.toString())) {
      // change quantity...
      _items.update(
        productId.toString(),
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity!+quantity,
          urlImage: existingCartItem.urlImage
        ),
      );
    } else {
      _items.putIfAbsent(
        productId.toString(),
            () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: quantity,
          urlImage: urlImage
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
          productId.toString(),
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            urlImage: existingCartItem.urlImage,
            quantity: existingCartItem.quantity!- 1,
          ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }


  setState() {
    notifyListeners();
  }
}