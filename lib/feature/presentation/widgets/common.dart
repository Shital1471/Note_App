import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

void snackBarError({String? msg,GlobalKey<ScaffoldState>? scaffoldState}){
  ScaffoldMessenger.of(scaffoldState!.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$msg"),
          Icon(FontAwesome.exclamation_triangle)
        ],
      ),
    ),
  );
}