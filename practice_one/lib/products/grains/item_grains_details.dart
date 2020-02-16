import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/cart_repository.dart';
import 'package:practice_one/models/product_grains.dart';
import 'package:practice_one/payment/payment.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/favorite_widget.dart';
import 'package:practice_one/utils/themes.dart';
import 'package:toast/toast.dart';

class GrainDetail extends StatefulWidget {
  final ProductGrains grain;

  GrainDetail({
    Key key,
    @required this.grain,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GrainDetailState();
  }
}

class _GrainDetailState extends State<GrainDetail> {
  int _value = 0;

  _openPaymentPage(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => Payment(total: widget.grain.productPrice,))
    );
  }
  
  void _updateWeight(ProductWeight weight) {
    switch(weight) {
      case ProductWeight.CUARTO:
        widget.grain.productWeight = weight;
        widget.grain.updateWeight();
        break;
      case ProductWeight.KILO:
        widget.grain.productWeight = weight;
        widget.grain.updateWeight();
        break;
    }
  }

  void _initValue(ProductWeight weight) {
    switch(weight) {
      case ProductWeight.CUARTO:
        _value = 0;
        break;
      case ProductWeight.KILO:
        _value = 1;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.grain);
    _initValue(widget.grain.productWeight);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.grain.productTitle),
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
                            widget.grain.productImage,
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
                          child: FavIcon(
                            isFavorite: widget.grain.liked,
                            callback: () {
                              print('callback');
                              widget.grain.liked = !widget.grain.liked;
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
                              widget.grain.productTitle,
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
                              widget.grain.productDescription,
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
                          Formatter.currencyFormat(widget.grain.productPrice),
                          style: ThemeUtil.detailPriceTheme(),
                        )
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget> [
                          ChoiceChip(
                            label: Text('250g'),
                            selected: _value == 0,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = 0;
                                _updateWeight(ProductWeight.CUARTO);
                              });
                            },
                          ),

                          ChoiceChip(
                            label: Text('1 Kg'),
                            selected: _value == 1,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = 1;
                                _updateWeight(ProductWeight.KILO);
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
                          var added = CartRepository.addProduct(widget.grain);
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