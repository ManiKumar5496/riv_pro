import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cart/logic/cart_provider.dart';
import '../../login/logic/login_controller.dart';
import '../logic/home_controller.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final homeData = ref.watch(homeDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: homeData.when(
        data: (homeData) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: homeData.carts.length, // Length of the carts list
            itemBuilder: (context, index) {
              final product = homeData.carts[index]
                  .products; // Get the list of products in that cart

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          // Assuming that you want to display the first product in the cart
                          if (product.isNotEmpty)
                            Text(
                              product[0]
                                  .title, // Display the title of the first product
                              style: const TextStyle(
                                fontFamily: "brandaRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),

                          const SizedBox(height: 4),
                          if (product.isNotEmpty)
                            Text(
                              product[0].id.toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          if (product.isNotEmpty)
                            Text(
                              'Price: \$${product[0].price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 20,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add product to cart when button is pressed
                                ref
                                    .read(cartProvider.notifier)
                                    .addToCart(product[0]);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Item added to cart!')),
                                );
                              },
                              child: const Text('Add to Cart'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
