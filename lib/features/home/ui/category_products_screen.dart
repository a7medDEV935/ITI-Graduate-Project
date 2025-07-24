import 'package:flutter/material.dart';

import '../data/models/product_model.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;
  final List<ProductModel> products;

  const CategoryProductsScreen({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.network(
                product.images.isNotEmpty ? product.images.first : '',
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
              title: Text(product.title),
              subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
            ),
          );
        },
      ),
    );
  }
}
