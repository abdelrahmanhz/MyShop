import 'package:flutter/material.dart';
import 'package:my_shop/providers/auth.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/screens/products_overview_screen.dart';
import 'package:my_shop/screens/splash_screen.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_products_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProduct) => previousProduct!..setListAndToken(
                auth.token ?? '',
                previousProduct == null ? [] : previousProduct.items,
                auth.userId ?? ''),
          create: (ctx) => Products('', [], ''),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders()
            ..setOrdersAndToken(
                auth.token ?? '',
                previousOrders == null ? [] : previousOrders.orders,
                auth.userId ?? ''),
          create: (ctx) => Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailsScreen.route: (ctx) => ProductDetailsScreen(),
            CartScreen.route: (ctx) => CartScreen(),
            OrdersScreen.route: (ctx) => OrdersScreen(),
            UserProductsScreen.route: (ctx) => UserProductsScreen(),
            EditProductsScreen.route: (ctx) => EditProductsScreen(),
            AuthScreen.route: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: const Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
