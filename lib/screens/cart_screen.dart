import 'package:flutter/material.dart';

import 'package:tiny_shop/components/cart_item.dart';
import 'package:tiny_shop/models/products_response.dart';
import 'package:tiny_shop/store/cart_store.dart';

class CartScreen extends StatelessWidget {
  final List<ProductResponseData> products;

  const new({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final cartStore = CartScope.of(context);
    final cartProducts = products
        .where((element) => cartStore.items.containsKey(element.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Cart'), backgroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 12),

                            Text(
                              'Your cart is empty',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              'Add items to start shopping',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final cartProduct = cartProducts[index];
                          final cartQuantity =
                              cartStore.items[cartProduct.id] ?? 1;
                          final productId = cartProduct.id;

                          return CartItem(
                            product: cartProduct,
                            quantity: cartQuantity,
                            onQuantityChanged: (quantity) async {
                              if (productId == null) return;

                              await cartStore.setQuantity(productId, quantity);
                            },
                          );
                        },
                      ),
              ),
              SizedBox(height: 14),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    Text(
                      'Checkout',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
