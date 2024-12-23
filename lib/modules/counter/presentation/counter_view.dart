import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../login/logic/login_controller.dart';
import '../logic/providers/counter_provider.dart';

class CounterView extends ConsumerStatefulWidget {
  const CounterView({super.key});

  @override
  ConsumerState<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends ConsumerState<CounterView> {
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(loginProvider.notifier).logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
          child: Text('Count: $count', style: const TextStyle(fontSize: 24))),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref
                .read(counterProvider.notifier)
                .increment(), // Use ref to read the provider
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => ref
                .read(counterProvider.notifier)
                .decrement(), // Use ref to read the provider
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
