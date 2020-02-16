import 'package:flutter/material.dart';
import 'package:practice_one/splash/splash.dart';
import 'package:practice_one/utils/constants.dart';
import 'package:practice_one/utils/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: _cuppingTheme,
      home: Splash(),
    );
  }
}

final _cuppingTheme = ThemeUtil.createAppTheme();


