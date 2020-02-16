import 'package:flutter/material.dart';
import 'package:practice_one/cart/cart.dart';
import 'package:practice_one/profile.dart';
import 'package:practice_one/utils/Formatter.dart';
import 'package:practice_one/utils/dialogs.dart';
import 'package:practice_one/utils/themes.dart';

class Payment extends StatefulWidget {

  final double total;
  Payment({
    Key key,
    @required this.total,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _PaymentState();
  }
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pagos'),
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Total ' + Formatter.currencyFormat(widget.total), style: ThemeUtil.categoryTitleTheme(),),
          ),
          Expanded(
            child:ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Dialogs.purchaseDialog(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSGEkvKwgMCRId9ItrGHJ6JcY5LOqJ8yg9A3hqM804ViQbPAbKd",
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text('PayPal', style: ThemeUtil.categoryTitleTheme(), textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                GestureDetector(
                    onTap: () {
                      Dialogs.purchaseDialog(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Image.network(
                                "https://cdn.pixabay.com/photo/2018/11/12/13/42/card-3810869_960_720.png",
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text('Tarjeta crédito', style: ThemeUtil.categoryTitleTheme(), textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                GestureDetector(
                    onTap: () {
                      Dialogs.purchaseDialog(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Image.network(
                                "https://cdn.pixabay.com/photo/2018/11/12/13/42/card-3810869_960_720.png",
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text('Tarjeta regalo', style: ThemeUtil.categoryTitleTheme(), textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      )
    );

  }
}