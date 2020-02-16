import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:practice_one/models/product.dart';
import 'package:practice_one/models/product_repository.dart';

enum ProductSize { CH, M, G }

class ProductDrinks extends Product {
  static const ProductType TYPE = ProductType.BEBIDAS;
  final String productTitle; // nombre del producto
  final String productDescription; // descripcion del producto
  final String productImage; // url de imagen del producto
  ProductSize productSize; // tamano del producto
  double productPrice; // precio del producto autocalculado
  int productAmount; // cantidad de producto por comprar
  bool liked;

  ProductDrinks({
    @required this.productTitle,
    @required this.productDescription,
    @required this.productImage,
    @required this.productSize,
    @required this.productAmount,
    this.liked = false,
  }) {
    // inicializa el precio de acuerdo a la size del producto
    productPrice = _productPriceCalculator();
  }

  void updatePrice() {
    this.productPrice = _productPriceCalculator();
  }

  double _productPriceCalculator() {
    if (this.productSize == ProductSize.CH)
      return (20 + Random().nextInt(40)).toDouble();
    if (this.productSize == ProductSize.M)
      return (40 + Random().nextInt(60)).toDouble();
    if (this.productSize == ProductSize.G)
      return (60 + Random().nextInt(80)).toDouble();
    return 999.0;
  }
}
