import 'package:flutter/material.dart';

Color? defaultColor(int selectColor){
  Color? color;
  switch(selectColor){
    case 0:
      return color =Colors.blue;
    case 1:
      return color = Colors.red;
    case 2:
      return color = Colors.teal;
    case 3:
      return color = Colors.purpleAccent;
    case 4:
      return color = Colors.amber;
    default:
      return color;
  }
}