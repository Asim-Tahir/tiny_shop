import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tiny_shop/models/products_response.dart';

class ProductAPIService {
  final Uri baseUri = Uri.parse('https://wantapi.com');

  Future<ProductsResponse> getAll() async {
    final Uri uri = baseUri.resolve('products.php');

    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);

      return ProductsResponse.fromJSON(data);
    }

    throw Exception('Failed to load products');
  }
}
