import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/toast.dart';
import '../data/models/product_model.dart';
import '../logic/cart/cart_cubit.dart';
import '../logic/cart/cart_state.dart';
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
      bottomNavigationBar: _buildAddToCartButton(product),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductDetailWidget(product: product),
            _buildSectionItem(
              context: context,
              title: 'related_products'.tr(),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: getIt<CartCubit>(),
                                child:
                                    RelatedProductsDetailPage(product: product),
                              ),
                            ),
                          );
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
              title: 'frequently_asked_questions'.tr(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFAQ(
                    context,
                    q: 'warranty_question'.tr(),
                    a: 'warranty_answer'.tr(),
                  ),
                  const SizedBox(height: 8),
                  _buildFAQ(
                    context,
                    q: 'return_question'.tr(),
                    a: 'return_answer'.tr(),
                  ),
                ],
              ),
            ),
            _buildSectionItem(
              context: context,
              title: 'shipping_information'.tr(),
              child: Text(
                'shipping_info_text'.tr(),
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

Widget _buildAddToCartButton(ProductModel product) {
  return Container(
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
      child: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) {
          return current is CartLoaded || current is CartInitial;
        },
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          final isInCart = cartCubit.isInCart(product);
          final quantity = cartCubit.getQuantityInCart(product);

          return isInCart
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  cartCubit.updateQuantity(
                                      product, quantity - 1);
                                } else {
                                  cartCubit.removeFromCart(product);
                                }
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartCubit.updateQuantity(product, quantity + 1);
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.white),
                        label: Text(
                          'update_cart'.tr(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          showWarningToast(
                              context: context,
                              message:
                                  'updated_in_cart'.tr(args: [product.title]));
                        },
                      ),
                    ),
                  ],
                )
              : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white),
                  label: Text(
                    'add_to_cart'.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    cartCubit.addToCart(product);
                    showSuccessToast(
                        context: context,
                        message: 'added_to_cart'.tr(args: [product.title]));
                  },
                );
        },
      ),
    ),
  );
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
      bottomNavigationBar: _buildAddToCartButton(product),
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
