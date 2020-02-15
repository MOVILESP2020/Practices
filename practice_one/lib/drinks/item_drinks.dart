import 'package:flutter/material.dart';
import 'package:practice_one/models/product_drinks.dart';

class ItemDrinks extends StatefulWidget {
  final ProductDrinks drink;
  ItemDrinks({
    Key key,
    @required this.drink,
  }) : super(key: key);

  @override
  _ItemDrinksState createState() => _ItemDrinksState();
}

class _ItemDrinksState extends State<ItemDrinks> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("${widget.drink.productTitle}"));
  }
}
