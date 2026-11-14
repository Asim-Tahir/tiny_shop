# Tiny Shop

Tiny Shop is a Flutter shopping app for browsing a product catalog and managing
a locally saved shopping cart.

## Features

- Loads products from the WantAPI product endpoint.
- Shows product cards and a detail screen with product information.
- Adds products to the cart and lets you change quantities or remove items.
- Saves cart contents on the device so they are restored when the app is opened
  again.

The catalog requires an internet connection. The search field and checkout
button are currently presentation-only; they do not perform search or checkout.

## Requirements

- Flutter SDK `^3.47.9` (stable).
- Dart SDK `^3.13.7` (the project constraint in `pubspec.yaml`).
- An Android or iOS device/simulator, or another supported Flutter target.

## Run locally

From the project directory:

```sh
flutter pub get
flutter run
```

## Tests and analysis

```sh
flutter test
flutter analyze
```

## Project structure

```text
lib/
  components/   Reusable product and cart widgets
  constants/    Cart storage key
  models/       Product catalog response models
  screens/      Home, product details, and cart screens
  services/     Product API client
  store/        Cart state and persistence
  theme/        Shared colors, sizing, spacing, and app theme
test/           Cart store tests
```
