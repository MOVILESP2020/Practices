import 'package:flutter/material.dart';
import 'package:practice_one/drinks/drinks_page.dart';
import 'package:practice_one/home/item_home.dart';
import 'package:practice_one/models/product_drinks.dart';
import 'package:practice_one/models/product_repository.dart';
import 'package:practice_one/profile.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: _openDrinksPage,
            child: ItemHome(
              title: "Bebidas",
              image: "https://i.blogs.es/723857/cafe_como/450_1000.jpg",
            ),
          ),
          ItemHome(
            title: "Cafe en grano",
            image: "https://www.elplural.com/uploads/s1/34/84/2/cafe.jpeg",
          ),
          ItemHome(
            title: "Tazas",
            image:
                "https://walkingmexico.com/wp-content/uploads/2015/02/Viajografi%CC%81a-Las-7-mejores-tazas-de-cafe%CC%81-en-el-D.F.-1.jpg",
          ),
        ],
      ),
    );
  }

  void _openDrinksPage() {
    // TODO: completar en navigator pasando los parametros a la pagina de DrinksPage

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return null;
        },
      ),
    );
  }

  void _openGrainsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => null),
    );
  }

  void _openCupsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => null),
    );
  }
}
