import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/cart_repository.dart';
import 'package:practice_one/models/product_drinks.dart';
import 'package:practice_one/payment/payment.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/favorite_widget.dart';
import 'package:practice_one/utils/themes.dart';
import 'package:toast/toast.dart';

class DrinkDetail extends StatefulWidget {
  final ProductDrinks drink;

  DrinkDetail({
    Key key,
    @required this.drink,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DrinkDetailState();
  }
}

class _DrinkDetailState extends State<DrinkDetail> {
  int _value = 0;

  void _updatePrice(ProductSize newSize) {
    widget.drink.productSize = newSize;
    widget.drink.updatePrice();
  }

  _openPaymentPage(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => Payment(total: widget.drink.productPrice,))
    );
  }

  void initValue(ProductSize size) {
    switch(size) {
      case ProductSize.CH:
        _value = 0;
        break;
      case ProductSize.M:
        _value = 1;
        break;
      case ProductSize.G:
        _value = 2;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.drink);
    initValue(widget.drink.productSize);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.drink.productTitle),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(
                top: 48,
                left: 36,
                right: 36,
                bottom: 36
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                 FittedBox(
                   fit: BoxFit.fill,
                   child:  Align(
                     alignment: Alignment.center,
                     child: Image.network(
                       widget.drink.productImage,
                       fit: BoxFit.fill,
                     ),
                   ),
                 ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        right: 8
                      ),
                      child:  FavIcon(
                        isFavorite: widget.drink.liked,
                        callback: () {
                          print('callback');
                          widget.drink.liked = !widget.drink.liked;
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(
                          24
                      ),
                      child: Text(
                          widget.drink.productTitle,
                          style: ThemeUtil.detailTitleTheme()
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          bottom: 24
                      ),
                      child: Text(
                          widget.drink.productDescription,
                          style: ThemeUtil.detailDescriptionTheme()
                      ),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Tamaños',
                    style: ThemeUtil.detailInfoTheme(),
                    ),
                    Text(
                      Formatter.currencyFormat(widget.drink.productPrice),
                      style: ThemeUtil.detailPriceTheme(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [
                    ChoiceChip(
                      label: Text('Chico'),
                      selected: _value == 0,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = 0;
                          _updatePrice(ProductSize.CH);
                        });
                      },
                    ),

                    ChoiceChip(
                      label: Text('Mediano'),
                      selected: _value == 1,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = 1;
                          _updatePrice(ProductSize.M);
                        });
                      },
                    ),

                    ChoiceChip(
                      label: Text('Grande'),
                      selected: _value == 2,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = 2;
                          _updatePrice(ProductSize.G);
                        });
                      },
                    ),

                  ]
                )
            ]),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: MaterialButton(
                    height: 48,
                    color: gray1,
                    child: Text('AGREGAR AL CARRITO', style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      var added = CartRepository.addProduct(widget.drink);
                      print(CartRepository.getCart());
                      if (added) {
                        Toast.show("Producto agregado", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                      } else {
                        Toast.show("Producto ya está en el carrito", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                      }

                    },
                  ),
                )
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    right: 8,
                    bottom: 8
                  ),
                  child: MaterialButton(
                    height: 48,
                    color: gray1,
                    child: Text('COMPRAR AHORA', style: TextStyle(color: Colors.white),),
                    onPressed: () => _openPaymentPage(context),
                  ),
                )
              ),
            ],
          )
        ],
      )
    );
  }
}