import 'package:flutter/material.dart';
import 'package:my_shop/screens/product_details_screen.dart';
import 'package:my_shop/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home:  ProductsOverviewScreen(),
      routes: {
        ProductDetailsScreen.route: (ctx) => ProductDetailsScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('MyShop'),
      ),
      body: Center(
          child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
