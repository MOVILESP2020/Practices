import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';

class FavIcon extends StatefulWidget {
  final bool isFavorite;
  final Function callback;
  FavIcon({Key key, this.isFavorite, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FavIconState();
  }
}

class _FavIconState extends State<FavIcon> {

  IconData _icon;
  bool _isFav;
  void _setIcon(bool isFavorite) {
    print("FAV " + isFavorite.toString());
    _icon = isFavorite ? Icons.favorite : Icons.favorite_border;
  }

  @override
  void initState() {
    _isFav = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setIcon(_isFav);
    return IconButton(
      icon: Icon(_icon),
      color: blue1, onPressed: (){
          setState(() {
            _isFav = !_isFav;
            _setIcon(_isFav);
            widget.callback();
          });
      },
    );
  }

}