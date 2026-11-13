import 'package:flutter/material.dart';

import 'package:tiny_shop/screens/home_screen.dart';
// import 'package:tiny_shop/screens/product_detail_screen.dart';
// import 'package:tiny_shop/screens/cart_screen.dart';


void main() {
  runApp(const TinyShopApp());
}

class TinyShopApp extends StatelessWidget {
  const TinyShopApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiny Shop',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
