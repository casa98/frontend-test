import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.grey[50],
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.grey[50],
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );
}
