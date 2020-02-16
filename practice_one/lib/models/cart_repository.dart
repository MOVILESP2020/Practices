
import 'package:practice_one/models/product.dart';
import 'dart:core';

class CartRepository {

  static Map _cart = new Map();

  static Map getCart() {
    return _cart;
  }
  static bool addProduct(Product product) {
    if (_cart[product.productTitle] != null) {
      return false;
    }
    _cart[product.productTitle] = product;
    return true;
  }
  static bool removeProduct(String key) {
    _cart.remove(key);
    return true;
  }

}
