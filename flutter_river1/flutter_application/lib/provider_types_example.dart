import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application/domain/entities/product_entity.dart';

// -----------------------------------------------------------------------------
// 1. Provider (Read-Only / Dependency Injection)
// -----------------------------------------------------------------------------
// Use this for values that don't change (like a service class or a constant string),
// or for computed values that depend on other providers.
final simpleStringProvider = Provider<String>((ref) {
  return "I am a constant string from a normal Provider.";
});

// -----------------------------------------------------------------------------
// 2. StateProvider (Simple Mutable State)
// -----------------------------------------------------------------------------
// Use this for simple variables that you need to change from the UI,
// like a counter, a filter selection, or a toggle switch.
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
}

final counterStateProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);

// -----------------------------------------------------------------------------
// 3. FutureProvider (Async Data)
// -----------------------------------------------------------------------------
// Use this for fetching data from the internet, a database, or any async operation.
// It handles loading, error, and data states for you.
final weatherFutureProvider = FutureProvider<String>((ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 2));
  return "Sunny, 25°C";
});

// -----------------------------------------------------------------------------
// 4. API FutureProvider (Real Data)
// -----------------------------------------------------------------------------
final productApiProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final response = await http.get(
    Uri.parse('https://fakestoreapi.com/products?limit=5'),
  );

  if (response.statusCode == 200) {
    final List data = json.decode(response.body);
    return data
        .map(
          (json) => ProductEntity(
            name: json['title'],
            price: (json['price'] as num).toDouble(),
          ),
        )
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
});

class ProviderTypesExample extends ConsumerWidget {
  const ProviderTypesExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Provider Types'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -----------------------------------------------------------------
            // Section 1: Provider
            // -----------------------------------------------------------------
            _buildHeader("1. Provider (Read-Only)"),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Text(
                ref.watch(simpleStringProvider),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),

            // -----------------------------------------------------------------
            // Section 2: StateProvider
            // -----------------------------------------------------------------
            _buildHeader("2. StateProvider (Mutable)"),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Counter: ${ref.watch(counterStateProvider)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Update the state
                      ref.read(counterStateProvider.notifier).increment();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Increment"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // -----------------------------------------------------------------
            // Section 3: FutureProvider
            // -----------------------------------------------------------------
            _buildHeader("3. FutureProvider (Async)"),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.orange[50],
              width: double.infinity,
              child: Consumer(
                builder: (context, ref, child) {
                  final asyncWeather = ref.watch(weatherFutureProvider);

                  return asyncWeather.when(
                    data: (data) => Column(
                      children: [
                        const Icon(
                          Icons.wb_sunny,
                          size: 50,
                          color: Colors.orange,
                        ),
                        Text(
                          data,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => ref.refresh(weatherFutureProvider),
                          child: const Text("Refresh Weather"),
                        ),
                      ],
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Text(
                      "Error: $err",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
