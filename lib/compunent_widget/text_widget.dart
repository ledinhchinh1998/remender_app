import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String title;
  final TextStyle style;

  TextComponent({this.title, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style
    );
  }
}
