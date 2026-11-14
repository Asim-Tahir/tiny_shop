import 'package:flutter/material.dart';

import 'package:tiny_shop/components/cart_item.dart';
import 'package:tiny_shop/models/products_response.dart';
import 'package:tiny_shop/store/cart_store.dart';
import 'package:tiny_shop/theme/app_tokens.dart';

class CartScreen extends StatelessWidget {
  final List<ProductResponseData> products;

  const new({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartStore = CartScope.of(context);
    final cartProducts = products
        .where((element) => cartStore.items.containsKey(element.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
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
                              size: AppSizes.emptyStateIcon,
                              color: AppColors.textMuted,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            Text(
                              'Your cart is empty',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.md),

                            Text(
                              'Add items to start shopping',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: AppColors.textMuted,
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
              const SizedBox(height: AppSpacing.relaxed),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimary,
                  minimumSize: const Size(
                    double.infinity,
                    AppSizes.buttonHeight,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpacing.sm,
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: AppColors.background,
                      size: 24,
                    ),
                    Text(
                      'Checkout',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.background,
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
