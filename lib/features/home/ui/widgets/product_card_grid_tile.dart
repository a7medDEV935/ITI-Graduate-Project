import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/toast.dart';
import '../../data/models/product_model.dart';
import '../../logic/cart/cart_cubit.dart';
import '../../logic/cart/cart_state.dart';

class ProductCardGridTile extends StatelessWidget {
  const ProductCardGridTile({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.images.isNotEmpty ? product.images.first : '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              product.category.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                ),
                BlocBuilder<CartCubit, CartState>(
                  buildWhen: (previous, current) {
                    return current is CartLoaded ||
                        current is CartInitial ||
                        current is CartError ||
                        current is CartLoading;
                  },
                  builder: (context, state) {
                    if (state is CartError) {
                      return const SizedBox(
                        height: 32,
                        child: Icon(Icons.error, size: 16, color: Colors.red),
                      );
                    }
                    if (state is CartLoading) {
                      return const SizedBox(
                        height: 32,
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }

                    final cartCubit = context.read<CartCubit>();
                    final isInCart = cartCubit.isInCart(product);
                    final quantity = cartCubit.getQuantityInCart(product);
                    return SizedBox(
                      height: 32,
                      child: isInCart
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    try {
                                      if (quantity > 1) {
                                        await cartCubit.updateQuantity(
                                            product, quantity - 1);
                                      } else {
                                        await cartCubit.removeFromCart(product);
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        showErrorToast(context: context, message: 'Error updating cart: $e');
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                InkWell(
                                  onTap: () async {
                                    try {
                                      await cartCubit.updateQuantity(
                                          product, quantity + 1);
                                    } catch (e) {
                                      if (context.mounted) {
                                       showErrorToast(context: context, message: 'Error updating cart: $e');
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: () async {
                                try {
                                  await cartCubit.addToCart(product);
                                  if (context.mounted) {
                                    showSuccessToast(context: context, message: '${product.title} added to cart!');
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                   showErrorToast(context: context, message: 'Error adding to cart: $e');
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.add_shopping_cart,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
