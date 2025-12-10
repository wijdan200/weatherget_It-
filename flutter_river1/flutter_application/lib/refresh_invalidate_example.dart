import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A provider that generates a random number after a short delay.
// We use .autoDispose so it resets if we leave the screen (optional here but good practice).
final randomNumberProvider = FutureProvider.autoDispose<int>((ref) async {

  print('Provider is executing (fetching new number)...');

  await Future.delayed(const Duration(seconds: 1));

  return Random().nextInt(100);
});

class RefreshInvalidateExample extends ConsumerWidget {
  const RefreshInvalidateExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(randomNumberProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Refresh vs Invalidate'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the current state of the provider
            asyncValue.when(
              data: (value) => Text(
                'Value: $value',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
            const SizedBox(height: 40),

            // Button to INVALIDATE
            ElevatedButton(
              onPressed: () {
                // Invalidate destroys the state immediately.
                // Since the widget is watching it, the provider will be re-executed immediately
                // to get the new state.
                // It returns void.
                print('User clicked Invalidate');
                ref.invalidate(randomNumberProvider);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text(
                'Invalidate (Reset State)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Invalidate: Marks the provider as "dirty". It will be disposed and re-initialized the next time it is read/watched.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            // Button to REFRESH
            ElevatedButton(
              onPressed: () {
               
                print('User clicked Refresh');
                final _ = ref.refresh(randomNumberProvider);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Refresh (Force Rebuild)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Refresh: Invalidates AND immediately reads the provider. Useful if you need the new value right away (e.g. for a Pull-to-Refresh).',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
