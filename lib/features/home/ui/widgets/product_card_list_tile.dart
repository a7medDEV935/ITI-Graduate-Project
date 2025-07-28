import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/widgets/toast.dart';
import '../../data/models/product_model.dart';
import '../../logic/cart/cart_cubit.dart';
import '../../logic/cart/cart_state.dart';

class ProductCardListTile extends StatelessWidget {
  const ProductCardListTile({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.images.isNotEmpty ? product.images.first : '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) {
                return current is CartLoaded ||
                    current is CartInitial ||
                    current is CartError ||
                    current is CartLoading;
              },
              builder: (context, state) {
                // Handle error state
                if (state is CartError) {
                  return ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.error, size: 16),
                    label: Text('error'.tr(), style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      foregroundColor: Colors.red,
                    ),
                  );
                }

                // Handle loading state
                if (state is CartLoading) {
                  return ElevatedButton.icon(
                    onPressed: null,
                    icon: const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    label: Text('loading'.tr(), style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.grey,
                    ),
                  );
                }

                final cartCubit = context.read<CartCubit>();
                final isInCart = cartCubit.isInCart(product);
                final quantity = cartCubit.getQuantityInCart(product);
                return isInCart
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
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
                                      showErrorToast(
                                          context: context,
                                          message: 'error_updating_cart'
                                              .tr(args: [e.toString()]));
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () async {
                                  try {
                                    await cartCubit.updateQuantity(
                                        product, quantity + 1);
                                  } catch (e) {
                                    if (context.mounted) {
                                      showErrorToast(
                                          context: context,
                                          message: 'error_updating_cart'
                                              .tr(args: [e.toString()]));
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'in_cart'.tr(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            await cartCubit.addToCart(product);
                            if (context.mounted) {
                              showSuccessToast(
                                  context: context,
                                  message: 'added_to_cart'
                                      .tr(args: [product.title]));
                            }
                          } catch (e) {
                            if (context.mounted) {
                              showErrorToast(
                                  context: context,
                                  message: 'error_adding_to_cart'
                                      .tr(args: [e.toString()]));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add_shopping_cart, size: 16),
                        label: Text(
                          'add'.tr(),
                          style: TextStyle(fontSize: 12),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
