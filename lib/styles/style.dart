// lib/styles/style.dart
import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(),
  labelText: '',
  filled: true,
  fillColor: Colors.white,
);

const kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple),
  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
    EdgeInsets.symmetric(vertical: 16.0),
  ),
  textStyle: MaterialStatePropertyAll<TextStyle>(
    TextStyle(fontSize: 18.0),
  ),
);

const kLinkStyle = TextStyle(
  decoration: TextDecoration.underline,
  color: Colors.blue,
);

const kMargin = EdgeInsets.symmetric(vertical: 8.0);
