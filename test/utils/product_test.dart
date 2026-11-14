import 'package:flutter_test/flutter_test.dart';

import 'package:tiny_shop/models/products_response.dart';
import 'package:tiny_shop/utils/product.dart';

void main() {
  final products = [
    ProductResponseData(
      name: 'Pixel Phone',
      tagline: 'A helpful phone',
      description: 'Made by Google',
    ),
    ProductResponseData(
      name: 'Galaxy Tablet',
      tagline: 'A large screen',
      description: 'A portable tablet',
    ),
  ];

  test('matches name, tagline, and description without case sensitivity', () {
    expect(searchProducts(products, ' PIXEL '), [products[0]]);
    expect(searchProducts(products, 'HELPFUL'), [products[0]]);
    expect(searchProducts(products, 'google'), [products[0]]);
    expect(searchProducts(products, 'TABLET'), [products[1]]);
  });

  test('returns all products for a blank query and none for no matches', () {
    expect(searchProducts(products, '  '), products);
    expect(searchProducts(products, 'not found'), isEmpty);
  });
}
