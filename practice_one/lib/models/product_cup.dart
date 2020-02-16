import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:practice_one/models/product.dart';
import 'package:practice_one/models/product_repository.dart';

enum ProductColor { R, B, W }

class ProductCups extends Product {
  static const ProductType TYPE = ProductType.TAZAS;
  final String productTitle; // nombre del producto
  final String productDescription; // descripcion del producto
  final String productImage; // url de imagen del producto
  ProductColor productColor; // tamano del producto
  double productPrice; // precio del producto autocalculado
  int productAmount; // cantidad de producto por comprar
  bool liked;

  ProductCups({
    @required this.productTitle,
    @required this.productDescription,
    @required this.productImage,
    @required this.productColor,
    @required this.productAmount,
    this.liked = false,
  }) {
    // inicializa el precio de acuerdo a la size del producto
    productPrice = productColorCalculator();
  }

  void updatePrice() {
    this.productPrice = productColorCalculator();
  }

  double productColorCalculator() {
    if (this.productColor == ProductColor.R)
      return (20 + Random().nextInt(40)).toDouble();
    if (this.productColor == ProductColor.B)
      return (40 + Random().nextInt(60)).toDouble();
    if (this.productColor == ProductColor.W)
      return (60 + Random().nextInt(80)).toDouble();
    return 999.0;
  }
}
