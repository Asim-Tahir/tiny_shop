import 'package:flutter/material.dart';

import 'package:tiny_shop/models/products_response.dart';
import 'package:tiny_shop/store/cart_store.dart';
import 'package:tiny_shop/theme/app_tokens.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductResponseData product;

  const new({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartStore = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.product.image!,
                height: AppSizes.productImageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name!,
                      style: theme.textTheme.headlineSmall,
                    ),

                    const SizedBox(height: AppSpacing.xs),

                    Text(
                      widget.product.tagline!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.compact),

                    Text('Description', style: theme.textTheme.titleLarge),

                    const SizedBox(height: AppSpacing.xs),

                    Text(
                      widget.product.description!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.5,
                        color: AppColors.textSubtle,
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    const SizedBox(height: AppSpacing.compact),

                    Text(
                      widget.product.price!,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.compact),

                    ElevatedButton(
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
                              backgroundColor: AppColors.danger,
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
                            backgroundColor: AppColors.success,
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.xxxl + AppSizes.buttonHeight,
                              left: AppSpacing.xl,
                              right: AppSpacing.xl,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: AppSpacing.md,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.background,
                            size: 24,
                          ),
                          Text(
                            'Add to Cart',
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
            ],
          ),
        ),
      ),
    );
  }
}
