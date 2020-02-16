import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/product_drinks.dart';
import 'package:practice_one/products/drinks/item_drinks_details.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/favorite_widget.dart';
import 'package:practice_one/utils/themes.dart';

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
    return GestureDetector(
      onTap: () {
        print("tap");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => DrinkDetail(drink: widget.drink,))
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
                                  '${widget.drink.productTitle}',
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
                                  '${widget.drink.productDescription}',
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
                                  '${Formatter.currencyFormat(widget.drink.productPrice)}',
                                  textAlign: TextAlign.left,
                                  style: ThemeUtil.productTitleTheme(),
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
                              child: Image.network(widget.drink.productImage, width: 180, height: 180, fit: BoxFit.fill,),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: FavIcon(
                                  isFavorite: widget.drink.liked,
                                  callback: () {
                                    print('callback');
                                    widget.drink.liked = !widget.drink.liked;
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
