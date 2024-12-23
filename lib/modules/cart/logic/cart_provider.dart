import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/data/model/product_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]) {
    _loadCart();
  }

  // Box where cart items are stored
  late Box<Product> _cartBox;

  // Load cart items from Hive on initialization
  Future<void> _loadCart() async {
    _cartBox = await Hive.openBox<Product>('cart');
    state = _cartBox.values.toList();
  }

  // Add a product to the cart and save it to Hive
  void addToCart(Product product) {
    state = [...state, product];
    _cartBox.add(product); // Add to the Hive box
  }

  //Remove a product from the cart and update Hive
  void removeFromCart(Product product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  // Clear all products from the cart and from Hive
  void clearCart() {
    state = [];
    _cartBox.clear();
  }
}
