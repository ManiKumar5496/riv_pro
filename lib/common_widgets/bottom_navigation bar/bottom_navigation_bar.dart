import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/cart/presentation/cart_view.dart';
import '../../modules/counter/presentation/counter_view.dart';
import '../../modules/home/presentation/home_view.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _currentIndex = 0; // Keeps track of selected tab index

  // List of widgets for each tab
  final List<Widget> _pages = [
    const HomeView(),
    const CartScreen(),
    const CounterView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display current selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the selected tab
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Counter',
          ),
        ],
      ),
    );
  }
}
