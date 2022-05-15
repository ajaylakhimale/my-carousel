import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_ui_kit/carousel.dart';

void main() => runApp(TheApp());

class TheApp extends StatelessWidget {
  const TheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffD0d4e3),
        body: Column(children: const [
          SizedBox(height: 50),
          Text('Custom Carousel below.'),
          Carousel(),
        ]),
      ),
    );
  }
}
