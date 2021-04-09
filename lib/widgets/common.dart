import 'package:flutter/material.dart';

InputDecoration textBoxDecoration(String name, IconData icon) {
  return InputDecoration(
    hintText: name,
    hintStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    filled: true,
    prefixIcon: Icon(
      icon,
      color: Colors.black,
    ),
    fillColor: Colors.deepPurple.shade100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
  );
}

Color scaffoldBG = Colors.deepPurple;
