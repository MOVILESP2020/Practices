import 'package:flutter/material.dart';
import 'package:practice_one/cart/cart.dart';
import 'package:practice_one/models/product_cup.dart';
import 'package:practice_one/products/cups/item_cups.dart';
import 'package:practice_one/profile.dart';

class CupsPage extends StatelessWidget {
  final List<ProductCups> cupsList;
  CupsPage({
    Key key,
    @required this.cupsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tazas'),
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
        itemCount: cupsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemCups(
            cup: cupsList[index],
          );
        },
      ),
    );
  }
}
