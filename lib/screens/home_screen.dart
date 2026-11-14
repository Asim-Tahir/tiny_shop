import "package:flutter/material.dart";

import "package:tiny_shop/components/product_card.dart";
import "package:tiny_shop/models/products_response.dart";
import "package:tiny_shop/screens/cart_screen.dart";
import "package:tiny_shop/services/api_services.dart";
import "package:tiny_shop/store/cart_store.dart";

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
    final cartStore = CartScope.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    icon: Badge(
                      isLabelVisible: cartStore.itemCount > 0,
                      label: Text(
                        '${cartStore.itemCount}',
                        style: TextStyle(fontSize: 14),
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

              SizedBox(height: 8),

              Text(
                'Find your perfect device.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://wantapi.com/assets/banner.png',
                  width: double.infinity,
                  height: 80,
                  fit: BoxFit.fitWidth,
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ProductCard(product: product);
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
