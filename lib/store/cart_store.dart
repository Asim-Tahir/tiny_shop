import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiny_shop/constants/cart.dart';

class CartPersistenceException implements Exception {
  const CartPersistenceException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

class CartStore extends ChangeNotifier {
  CartStore(this._preferences);

  final SharedPreferences _preferences;
  final Map<int, int> _items = {};
  Future<void> _writeQueue = Future<void>.value();
  bool _isLoaded = false;

  Map<int, int> get items => Map.unmodifiable(_items);

  int get itemCount =>
      _items.values.fold<int>(0, (total, quantity) => total + quantity);

  Future<void> load() async {
    if (_isLoaded) return;

    final savedItems = _preferences.getString(cartItemsStorageKey);
    if (savedItems != null) {
      final decoded = jsonDecode(savedItems);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Saved cart data must be a JSON object.');
      }

      final restoredItems = <int, int>{};
      for (final entry in decoded.entries) {
        final productId = int.tryParse(entry.key);
        final quantity = entry.value;
        if (productId == null || quantity is! int || quantity <= 0) {
          throw const FormatException('Saved cart data is invalid.');
        }
        restoredItems[productId] = quantity;
      }
      _items.addAll(restoredItems);
    }

    _isLoaded = true;
  }

  Future<void> addItem(int productId) {
    return _updateItems((items) {
      items.update(productId, (quantity) => quantity + 1, ifAbsent: () => 1);
    });
  }

  Future<void> setQuantity(int productId, int quantity) {
    return _updateItems((items) {
      if (quantity <= 0) {
        items.remove(productId);
      } else {
        items[productId] = quantity;
      }
    });
  }

  Future<void> _updateItems(void Function(Map<int, int>) update) {
    if (!_isLoaded) {
      throw StateError('Call load() before updating the cart.');
    }

    final operation = _writeQueue.then((_) async {
      final updatedItems = Map<int, int>.of(_items);
      update(updatedItems);
      await _save(updatedItems);
      _items
        ..clear()
        ..addAll(updatedItems);
      notifyListeners();
    });

    _writeQueue = operation.then<void>(
      (_) {},
      onError: (Object error, StackTrace stackTrace) {},
    );
    return operation;
  }

  Future<void> _save(Map<int, int> items) async {
    try {
      final saved = await _preferences.setString(
        cartItemsStorageKey,
        jsonEncode({
          for (final entry in items.entries) '${entry.key}': entry.value,
        }),
      );
      if (!saved) {
        throw const CartPersistenceException('Failed to save the cart.');
      }
    } on PlatformException catch (error) {
      throw CartPersistenceException('Failed to save the cart.', error);
    }
  }
}

class CartScope extends InheritedNotifier<CartStore> {
  const CartScope({
    super.key,
    required CartStore notifier,
    required super.child,
  }) : super(notifier: notifier);

  static CartStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope not found in widget tree');
    return scope!.notifier!;
  }
}
