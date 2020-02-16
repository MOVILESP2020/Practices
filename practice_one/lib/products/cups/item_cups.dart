import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/product_cup.dart';
import 'package:practice_one/products/cups/item_cup_details.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/favorite_widget.dart';
import 'package:practice_one/utils/themes.dart';

class ItemCups extends StatefulWidget {
  final ProductCups cup;
  ItemCups({
    Key key,
    @required this.cup,
  }) : super(key: key);

  @override
  _ItemDrinksState createState() => _ItemDrinksState();
}

class _ItemDrinksState extends State<ItemCups> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("tap");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => CupDetail(cup: widget.cup,))
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 80,
          height: 200,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                color: gray1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only( left: 8),
                                child: Text(
                                  '${widget.cup.productTitle}',
                                  textAlign: TextAlign.left,
                                  style: ThemeUtil.productTitleTheme(),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only( left: 8),
                                child: Text(
                                  '${widget.cup.productDescription}',
                                  textAlign: TextAlign.left,
                                  style: ThemeUtil.productDescriptionTheme(),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only( left: 8),
                                child: Text(
                                  '${Formatter.currencyFormat(widget.cup.productPrice)}',
                                  textAlign: TextAlign.left,
                                  style: ThemeUtil.productPriceTheme(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded (
                      flex: 6,
                      child: Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.network(widget.cup.productImage, width: 180, height: 180, fit: BoxFit.fill),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: FavIcon(
                                  isFavorite: widget.cup.liked,
                                  callback: () {
                                    print('callback');
                                    widget.cup.liked = !widget.cup.liked;
                                  },
                                )
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
}
