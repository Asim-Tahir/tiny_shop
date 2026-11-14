import 'package:tiny_shop/models/products_response.dart';

List<ProductResponseData> searchProducts(
  List<ProductResponseData> products,
  String query,
) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) return products;

  return products.where((product) {
    return [
      product.name,
      product.tagline,
      product.description,
    ].any((field) => field?.toLowerCase().contains(normalizedQuery) ?? false);
  }).toList();
}
