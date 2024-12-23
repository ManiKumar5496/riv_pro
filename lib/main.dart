import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:riv_pro/modules/home/presentation/home_view.dart';
import 'package:riv_pro/modules/login/presentation/login_view.dart';
import 'app_routes/app_routes.dart';
import 'app_routes/navigation_services.dart';
import 'common_widgets/bottom_navigation bar/bottom_navigation_bar.dart';
import 'modules/counter/presentation/counter_view.dart';
import 'modules/login/logic/login_controller.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

var log = Logger(
  printer: PrettyPrinter(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod',
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => Consumer(builder: (context, ref, child) {
              final loginState = ref.watch(loginProvider);
              if (loginState.isLoggedIn) {
                return BottomNavBarExample();
              } else {
                return LoginView();
              }
            }),
        AppRoutes.home: (context) => HomeView(),
        AppRoutes.counter: (context) => CounterView(),
      },
    );
  }
}
