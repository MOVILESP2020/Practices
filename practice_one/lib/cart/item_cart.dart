import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/models/cart_repository.dart';
import 'package:practice_one/models/product.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/favorite_widget.dart';
import 'package:practice_one/utils/themes.dart';

class ItemCart extends StatefulWidget {

  final Product product;
  final Function(Product p) add;
  final Function(Product p) remove;
  final Function(double amount) onDeleteProduct;

  ItemCart({
    Key key,
    @required this.product,
    this.add,
    this.remove,
    this.onDeleteProduct
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemCartState();
  }
}

class _ItemCartState extends State<ItemCart> {

  void _updateQty(int qty) {
    setState(() {
      widget.product.productAmount = qty;
    });
  }


  @override
  Widget build(BuildContext context) {
    return
      Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        color: orange2,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.network(widget.product.productImage, height: 150, fit:  BoxFit.fill,),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.product.productTitle, style: ThemeUtil.itemCartTitle(),),
                    Text(widget.product.productDescription, style: ThemeUtil.itemCartDescription(),),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                            color: blue1,
                          onPressed: (){
                            _updateQty(widget.product.productAmount + 1);
                            widget.add(widget.product);
                          },
                        ),
                        Text('${widget.product.productAmount}', style: ThemeUtil.itemCartQty(),),
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          color: blue1,
                          onPressed: (){
                            if(widget.product.productAmount >= 1) {
                              _updateQty(widget.product.productAmount - 1);
                              widget.remove(widget.product);
                            }
                          },
                        ),
                        Text(Formatter.currencyFormat(widget.product.productPrice), style: ThemeUtil.itemCartPrice(),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FavIcon(
                  isFavorite: widget.product.liked,
                  callback: () {

                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: blue1,
                  onPressed: () {
                    CartRepository.removeProduct(widget.product.productTitle);
                    widget.onDeleteProduct(
                      widget.product.productAmount * widget.product.productPrice
                    );
                  },
                )
              ],
            )
          ],
      )
    );
  }
}
