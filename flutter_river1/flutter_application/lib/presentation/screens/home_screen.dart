import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../providers/sort_provider.dart';
import 'package:flutter_application/domain/entities/product_entity.dart';
import 'refresh_invalidate_example_screen.dart';
import 'webview_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productApiProvider);
    final sortType = ref.watch(sortProductProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 176, 247),
        title: const Text("Products"),
        shadowColor: const Color(0xFF000000),
        actions: [
          IconButton(
            icon: const Icon(Icons.web),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebViewScreen(
                    url: 'https://fakestoreapi.com/products?limit=5',
                    title: 'Products API',
                  ),
                ),
              );
            },
            tooltip: 'Open Products API in WebView',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RefreshInvalidateExampleScreen(),
                ),
              );
            },
            tooltip: 'Go to Refresh/Invalidate Example',
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          final List<ProductEntity> sortedProducts = List.from(products);

          if (sortType == SortType.name) {
            sortedProducts.sort((a, b) => a.name.compareTo(b.name));
          } else {
            sortedProducts.sort((a, b) => a.price.compareTo(b.price));
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(productApiProvider);
            },
            child: ListView.builder(
              itemCount: sortedProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 218, 167, 184),
                        width: 1,
                      ),
                    ),
                    title: Text(sortedProducts[index].name),
                    subtitle: Text(
                      '\$${sortedProducts[index].price.toStringAsFixed(2)}',
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(productApiProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: DropdownButton<SortType>(
          value: sortType,
          underline: const SizedBox(),
          items: const [
            DropdownMenuItem(value: SortType.name, child: Text("Name")),
            DropdownMenuItem(value: SortType.price, child: Text("Price")),
          ],
          onChanged: (value) {
            if (value != null) {
              ref.read(sortProductProvider.notifier).setSortType(value);
            }
          },
        ),
      ),
    );
  }
}
