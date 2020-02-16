import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';
import 'package:practice_one/utils/themes.dart';

class Dialogs {
  static void onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(backgroundColor: blue1, ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  static void purchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTUj_j8YRbcKVTApvdbtEWpS-wWhazygK_bke5XSMgpWwlZ9oqu",
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  left: 8
                ),
                child: Text('!Orden exitosa!', style: ThemeUtil.paymentDialogTitle(),),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 8
                ),
                child: Text('Cupping', style: ThemeUtil.paymentDialogSubtitle(),),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 8,
                    left: 8
                ),
                child: Text(
                    'Tu orden ha sido registrada, para más información busca en la sección historial de compras en tu perfil.',
                  style: ThemeUtil.paymentDialogMessage(),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    child: Text('Aceptar', style: ThemeUtil.paymentDialogButton(),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}