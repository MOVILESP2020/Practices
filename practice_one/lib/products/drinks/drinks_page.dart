import 'package:flutter/material.dart';
import 'package:practice_one/cart/cart.dart';
import 'package:practice_one/models/product_drinks.dart';
import 'package:practice_one/products/drinks/item_drinks.dart';
import 'package:practice_one/profile.dart';

class DrinksPage extends StatelessWidget {
  final List<ProductDrinks> drinksList;
  DrinksPage({
    Key key,
    @required this.drinksList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bebidas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Profile()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Cart()),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: drinksList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemDrinks(
            drink: drinksList[index],
          );
        },
      ),
    );
  }
}
