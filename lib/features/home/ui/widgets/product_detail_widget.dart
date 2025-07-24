import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({super.key, required this.product});
  final ProductModel product;
  String _formatDate(String isoDate) => DateTime.parse(isoDate).toHumanized();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.images.isNotEmpty)
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 250,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: product.images.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      imgUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 50),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        const SizedBox(height: 20),
        Text(
          product.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.category, size: 20, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              product.category.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              'Created: ${_formatDate(product.creationAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.update, size: 18, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              'Updated: ${_formatDate(product.updatedAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
