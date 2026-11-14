# Tiny Shop

Tiny Shop is a Flutter shopping app for browsing a product catalog and managing
a locally saved shopping cart.

## Screenshots

<table>
  <tbody>
    <tr>
      <td align="center">
        <figure>
          <img width="260" alt="Tiny Shop product catalog screen" src="https://github.com/user-attachments/assets/87dfc4af-4bcc-4bc7-b5fa-8d9b9c3ba73c" />
          <br/>
          <figcaption>Product catalog</figcaption>
        </figure>
      </td>
      <td align="center">
        <figure>
          <img width="260" alt="Tiny Shop product details screen" src="https://github.com/user-attachments/assets/331dd30a-bc76-4bb9-99df-ec51b4569e70" />
          <br/>
          <figcaption>Product details</figcaption>
        </figure>
      </td>
      <td align="center">
        <figure>
          <img width="260" alt="Tiny Shop add to cart product action" src="https://github.com/user-attachments/assets/6e466724-0f39-4533-96ce-d82713b0d2e2" />
          <br/>
          <figcaption>Add to cart product action</figcaption>
        </figure>
      </td>
    </tr>
    <tr>
      <td align="center">
        <figure>
          <img width="260" alt="Tiny Shop product catalog with filled cart" src="https://github.com/user-attachments/assets/1997421c-231e-4b7a-bff1-18d0f25fd4b1" />
          <br/>
          <figcaption>Product catalog with filled cart</figcaption>
        </figure>
      </td>
      <td align="center">
        <figure>
          <img width="260" alt="Tiny Shop shopping cart screen" src="https://github.com/user-attachments/assets/06b67d3d-b7d4-484c-ade5-e215ff0b6adc" />
          <br/>
          <figcaption>Shopping cart</figcaption>
        </figure>
      </td>
      <td align="center">
        <figure>
          <img width="260" alt="Tiny Shop search product by name, tagline, or description" src="https://github.com/user-attachments/assets/56b17ba1-e357-4ce9-a09d-289e794d5ebe" />
          <br/>
          <figcaption>Search product by name, tagline, or description</figcaption>
        </figure>
      </td>
    </tr>
    <tr>
      <td align="center">
        <figure>
            <img width="260" alt="Tiny Shop not found searched products" src="https://github.com/user-attachments/assets/0d9aa081-f04c-482e-a4a5-277b75c8f912" />
              <br/>
              <figcaption>Not found searched products</figcaption>
          </figure>
      </td>
      <td align="center"></td>
      <td align="center"></td>
    </tr>
  </tbody>
</table>

## Features

- Loads products from the WantAPI product endpoint.
- Shows product cards and a detail screen with product information.
- Filters the loaded catalog by product name, tagline, or description as you
  type, with a clear-search control.
- Adds products to the cart and lets you change quantities or remove items.
- Saves cart contents on the device so they are restored when the app is opened
  again.

The catalog requires an internet connection. Search filters the products
already loaded into the catalog. The checkout button is currently
presentation-only and does not perform checkout.

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
