import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiny_shop/screens/home_screen.dart';
import 'package:tiny_shop/store/cart_store.dart';
import 'package:tiny_shop/theme/app_tokens.dart';

void main() {
  runApp(const TinyShopApp());
}

class TinyShopApp extends StatefulWidget {
  const TinyShopApp({super.key});

  @override
  State<TinyShopApp> createState() => _TinyShopAppState();
}

class _TinyShopAppState extends State<TinyShopApp> {
  late final Future<CartStore> _cartStoreFuture = _createCartStore();
  CartStore? _cartStore;

  Future<CartStore> _createCartStore() async {
    final preferences = await SharedPreferences.getInstance();
    final cartStore = CartStore(preferences);
    await cartStore.load();
    return cartStore;
  }

  @override
  void dispose() {
    _cartStore?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CartStore>(
      future: _cartStoreFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Unable to load the saved cart: ${snapshot.error}'),
              ),
            ),
          );
        }

        final cartStore = snapshot.data;
        if (cartStore == null) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        _cartStore = cartStore;

        return CartScope(
          notifier: cartStore,
          child: MaterialApp(
            title: 'Tiny Shop',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
