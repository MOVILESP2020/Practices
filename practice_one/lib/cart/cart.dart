import 'package:flutter/material.dart';
import 'package:practice_one/cart/item_cart.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/cart_repository.dart';
import 'package:practice_one/models/product.dart';
import 'package:practice_one/payment/payment.dart';
import 'package:practice_one/profile.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/themes.dart';

class Cart extends StatefulWidget {
  final List<dynamic> productList;
  Cart({
    Key key,
    this.productList,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  double _total = 0.0;

  _openPaymentPage(context) {
    Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Payment(total: _total,))
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartRepository.getCart().forEach((key, value) {
      Product p = (value as Product);
      _total += (p.productAmount * p.productPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(CartRepository.getCart());
    //initT();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrito'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Profile()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 75,
            child: Container(
              child: ListView.builder(
                itemCount: CartRepository.getCart().length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = CartRepository.getCart().keys.elementAt(index);
                    Product product = CartRepository.getCart()[key];
                    return ItemCart(
                      product: product,
                      add: (p) {
                          setState(() {
                            _total += p.productPrice;
                          });
                      },
                      remove: (p) {
                        setState(() {
                          _total -= p.productPrice;
                        });
                      },
                      onDeleteProduct: (amount) {
                        setState(() {
                          _total -= amount;
                        });
                      },
                    );
                  }
              ),
            ),
          ),
          Expanded(
            flex: 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Total', style: ThemeUtil.detailDescriptionTheme(),),
                    Text(Formatter.currencyFormat(_total), style: ThemeUtil.detailPriceTheme(),)
                  ],
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Padding(
                    padding: EdgeInsets.all(
                        16
                    ),
                    child: MaterialButton(
                      height: 48,
                      color: gray1,
                      child: Text('PAGAR'),
                      onPressed: () {
                        _openPaymentPage(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
