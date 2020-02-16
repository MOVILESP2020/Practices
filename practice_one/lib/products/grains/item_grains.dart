import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/product_grains.dart';
import 'package:practice_one/products/grains/item_grains_details.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/favorite_widget.dart';
import 'package:practice_one/utils/themes.dart';

class ItemGrains extends StatefulWidget {
  final ProductGrains grain;
  ItemGrains({
    Key key,
    @required this.grain,
  }) : super(key: key);

  @override
  _ItemDrinksState createState() => _ItemDrinksState();
}

class _ItemDrinksState extends State<ItemGrains> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("tap");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => GrainDetail(grain: widget.grain,))
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
                                child: Text('${
                                    widget.grain.productTitle}',
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
                                  '${widget.grain.productDescription}',
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
                                  Formatter.currencyFormat(widget.grain.productPrice),
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
                              child: Image.network(widget.grain.productImage, width: 180, height: 180, fit: BoxFit.fill),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child:  FavIcon(
                                  isFavorite: widget.grain.liked,
                                  callback: () {
                                    print('callback');
                                    widget.grain.liked = !widget.grain.liked;
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
