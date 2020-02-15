import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<dynamic> productList;
  Cart({
    Key key,
    @required this.productList,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
