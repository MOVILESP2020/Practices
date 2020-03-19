import 'package:flutter/foundation.dart';

class Apunte {
  final String materia;
  final String descripcion;
  final String imageUrl;

  Apunte({
    @required this.materia,
    @required this.descripcion,
    @required this.imageUrl,
  });

  @override
  String toString() {
    return "Materia: $materia, Descripción: $descripcion, Image: $imageUrl";
  }
}
