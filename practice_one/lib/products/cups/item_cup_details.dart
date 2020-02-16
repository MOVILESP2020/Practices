import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/cart_repository.dart';
import 'package:practice_one/models/product_cup.dart';
import 'package:practice_one/payment/payment.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/favorite_widget.dart';
import 'package:practice_one/utils/themes.dart';
import 'package:toast/toast.dart';

class CupDetail extends StatefulWidget {
  final ProductCups cup;

  CupDetail({
    Key key,
    @required this.cup,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CupDetailState();
  }
}

class _CupDetailState extends State<CupDetail> {

  _openPaymentPage(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => Payment(total: widget.cup.productPrice,))
    );
  }

  Color _cupColor = Colors.red;

  void _updateCupColor(Color newColor) {
    setState(() {
      _cupColor = newColor;
      if (_cupColor == Colors.red) {
        widget.cup.productColor = ProductColor.R;
        widget.cup.updatePrice();

      } else if (_cupColor == blue1) {
        widget.cup.productColor = ProductColor.B;
        widget.cup.updatePrice();
      } else {
        widget.cup.productColor = ProductColor.W;
        widget.cup.updatePrice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cup);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.cup.productTitle),
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
                            widget.cup.productImage,
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
                            isFavorite: widget.cup.liked,
                            callback: () {
                              print('callback');
                              widget.cup.liked = !widget.cup.liked;
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
                  Padding(
                    padding: EdgeInsets.all(
                      24
                    ),
                    child: Text(
                        widget.cup.productTitle,
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
                        widget.cup.productDescription,
                        style: ThemeUtil.detailDescriptionTheme()
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: <Widget>[
                            Text(
                                'COLORES',
                                style: ThemeUtil.detailInfoTheme()
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => _updateCupColor(Colors.red),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color:  Colors.red
                                    ),
                                  ),
                                ),
                               GestureDetector(
                                 onTap: ()=>_updateCupColor(blue1),
                                 child: Container(
                                   width: 24,
                                   height: 24,
                                   decoration: BoxDecoration(
                                       border: Border.all(),
                                       color:  blue1
                                   ),
                                 )
                               ),
                                GestureDetector(
                                  onTap: ()=>_updateCupColor(Colors.white),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color:  Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Text(
                                        'PRECIO',
                                        style: ThemeUtil.detailInfoTheme()
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color:  _cupColor
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                  Formatter.currencyFormat(widget.cup.productPrice),
                                  style: ThemeUtil.detailPriceTheme()
                              )
                            ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
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
                          var added = CartRepository.addProduct(widget.cup);
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