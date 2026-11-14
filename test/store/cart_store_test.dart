import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiny_shop/store/cart_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<CartStore> createStore() async {
    final preferences = await SharedPreferences.getInstance();
    final store = CartStore(preferences);
    addTearDown(store.dispose);
    return store;
  }

  test('loads an empty cart and exposes an unmodifiable item map', () async {
    final store = await createStore();

    await store.load();

    expect(store.items, isEmpty);
    expect(store.itemCount, 0);
    expect(() => store.items[42] = 1, throwsUnsupportedError);
  });

  test('restores saved quantities and loads only once', () async {
    SharedPreferences.setMockInitialValues({'cart_items': '{"42":2,"7":3}'});
    final store = await createStore();

    await store.load();
    await store.load();

    expect(store.items, {42: 2, 7: 3});
    expect(store.itemCount, 5);
  });

  test(
    'adds items sequentially and notifies listeners after each save',
    () async {
      final store = await createStore();
      await store.load();
      var notifications = 0;
      void listener() => notifications++;
      store.addListener(listener);
      addTearDown(() => store.removeListener(listener));

      await Future.wait([store.addItem(42), store.addItem(42)]);

      expect(store.items, {42: 2});
      expect(store.itemCount, 2);
      expect(notifications, 2);
    },
  );

  test('sets quantities and removes items at zero or below', () async {
    final store = await createStore();
    await store.load();

    await store.setQuantity(42, 3);
    await store.setQuantity(7, 2);
    await store.setQuantity(42, 0);
    await store.setQuantity(7, -1);
    await store.setQuantity(99, 0);

    expect(store.items, isEmpty);
    expect(store.itemCount, 0);
  });

  test('rejects cart updates before loading', () async {
    final store = await createStore();

    expect(() => store.addItem(42), throwsStateError);
    expect(() => store.setQuantity(42, 2), throwsStateError);
  });

  test('rejects saved data that is not a JSON object', () async {
    SharedPreferences.setMockInitialValues({'cart_items': '[]'});
    final store = await createStore();

    await expectLater(store.load(), throwsFormatException);
  });

  test('rejects saved entries with invalid ids or quantities', () async {
    for (final savedCart in [
      '{"not-an-id":1}',
      '{"42":0}',
      '{"42":-1}',
      '{"42":"2"}',
    ]) {
      SharedPreferences.setMockInitialValues({'cart_items': savedCart});
      final store = await createStore();

      await expectLater(store.load(), throwsFormatException);
    }
  });

  testWidgets('CartScope exposes the store and rebuilds on updates', (
    tester,
  ) async {
    final store = await createStore();
    await store.load();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CartScope(
          notifier: store,
          child: Builder(
            builder: (context) => Text('${CartScope.of(context).itemCount}'),
          ),
        ),
      ),
    );
    expect(find.text('0'), findsOneWidget);

    await store.addItem(42);
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await Future.wait([store.addItem(7), store.addItem(7)]);
    await tester.pump();

    expect(find.text('3'), findsOneWidget);
  });
}
