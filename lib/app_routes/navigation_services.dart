import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, String>((ref) {
  return NavigationNotifier();
});

class NavigationNotifier extends StateNotifier<String> {
  NavigationNotifier() : super('/'); // Initial route

  void navigateTo(String route) {
    state = route; // Update the state to the new route
  }
}

// Custom navigation widget
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void navigateTo(String route) {
    navigatorKey.currentState?.pushNamed(route);
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }
}
