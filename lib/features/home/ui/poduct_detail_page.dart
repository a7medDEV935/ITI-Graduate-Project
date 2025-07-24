import 'package:final_project/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import 'widgets/product_detail_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> relatedProducts;
  const ProductDetailPage(
      {super.key, required this.product, required this.relatedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, -1),
            )
          ],
        ),
        child: SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Add to Cart'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.title} added to cart!'),
                ),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductDetailWidget(product: product),
            _buildSectionItem(
              context: context,
              title: 'Related products',
              child: Container(
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: relatedProducts.map((product) {
                      return GestureDetector(
                        onTap: () {
                          context.push(
                              RelatedProductsDetailPage(product: product));
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).colorScheme.tertiary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(5),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  product.images.first,
                                  height: 70,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.broken_image),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  product.title,
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            _buildSectionItem(
              context: context,
              title: 'Frequently Asked Questions',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFAQ(
                    context,
                    q: 'What is the warranty period for this product?',
                    a: 'The product comes with a one-year warranty covering manufacturing defects.',
                  ),
                  const SizedBox(height: 8),
                  _buildFAQ(
                    context,
                    q: 'Can I return the product if I am not satisfied?',
                    a: 'Yes, you can return the product within 30 days of purchase for a full refund, provided it is in its original condition.',
                  ),
                ],
              ),
            ),
            _buildSectionItem(
              context: context,
              title: 'Shipping Information',
              child: Text(
                'We offer free shipping on all orders over \$100. Orders are typically processed within 2-3 business days.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionItem(
      {required BuildContext context,
      required final String title,
      required final Widget child}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _styledTitle(
            context: context,
            title: title,
            fontSize: 20,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _styledTitle({
    required BuildContext context,
    required final String title,
    required final double? fontSize,
    required final TextStyle? style,
  }) {
    return Text(
      title,
      style: style ??
          Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildFAQ(BuildContext context,
      {required final String q, required final String a}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Q: $q',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text('A: $a', style: theme.textTheme.bodyMedium),
      ],
    );
  }
}

class RelatedProductsDetailPage extends StatelessWidget {
  const RelatedProductsDetailPage({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, -1),
            )
          ],
        ),
        child: SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Add to Cart'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.title} added to cart!'),
                ),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ProductDetailWidget(product: product),
        ),
      ),
    );
  }
}
