import 'package:flutter/material.dart';

import 'package:tiny_shop/models/products_response.dart';
import 'package:tiny_shop/store/cart_store.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductResponseData product;

  const new({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartStore = CartScope.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Back'), backgroundColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.product.image!,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      widget.product.tagline!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      widget.product.description!,
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    SizedBox(height: 10),

                    Text(
                      widget.product.price!,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue.shade800,
                      ),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final productId = widget.product.id;
                        if (productId == null) return;

                        try {
                          await cartStore.addItem(productId);
                        } on CartPersistenceException catch (error) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Added to Cart"),
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            duration: Durations.extralong4,
                            backgroundColor: Colors.green,
                            margin: EdgeInsets.only(
                              bottom: 80,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
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
