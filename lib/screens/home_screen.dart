import "package:flutter/material.dart";

import "package:tiny_shop/components/product_card.dart";
import "package:tiny_shop/models/products_response.dart";
import "package:tiny_shop/screens/cart_screen.dart";
import "package:tiny_shop/screens/product_detail_screen.dart";
import "package:tiny_shop/services/api_services.dart";
import "package:tiny_shop/store/cart_store.dart";
import "package:tiny_shop/theme/app_tokens.dart";

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiService = ProductAPIService();
  List<ProductResponseData> products = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await apiService.getAll();

      setState(() {
        products = response.data ?? [];
      });
    } catch (err) {
      setState(() {
        errorMessage = 'Failed to load products';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartStore = CartScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discover', style: theme.textTheme.displaySmall),

                  IconButton(
                    icon: Badge(
                      isLabelVisible: cartStore.itemCount > 0,
                      label: Text(
                        '${cartStore.itemCount}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      child: const Icon(Icons.shopping_bag_outlined, size: 28),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(products: products),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Find your perfect device.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textMuted,
                ),
              ),

              const SizedBox(height: AppSpacing.relaxed),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: const TextStyle(color: AppColors.textMuted),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.relaxed,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.md),
                child: Image.network(
                  'https://wantapi.com/assets/banner.png',
                  width: double.infinity,
                  height: AppSizes.bannerHeight,
                  fit: BoxFit.fitWidth,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.compact,
                    mainAxisSpacing: AppSpacing.compact,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: ProductCard(product: product),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
