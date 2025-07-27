import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/notifications_service.dart';
import '../../../../core/widgets/custom_action_slider.dart';
import '../../../../core/widgets/toast.dart';
import '../../data/models/cart_item.dart';
import '../../logic/cart/cart_cubit.dart';
import '../../logic/cart/cart_state.dart';
import '../../logic/notifications/notification_cubit.dart';
import '../../service/order_service.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  PersistentBottomSheetController? _sheetController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCheckoutBottomSheet(context);
    });
  }

  void _showCheckoutBottomSheet(BuildContext context) {
    final state = context.read<CartCubit>().state;
    if (state is CartLoaded &&
        state.cartItems.isNotEmpty &&
        _sheetController == null) {
      _sheetController = showBottomSheet(
        context: context,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: _buildCheckoutSection(context, state),
            ),
          ),
        ),
      );
      _sheetController?.closed.whenComplete(() {
        _sheetController = null;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController?.close();
      _sheetController = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          showErrorToast(context: context, message: state.message);
        }
        if (state is CartLoaded &&
            state.cartItems.isEmpty &&
            _sheetController != null) {
          _sheetController?.close();
          _sheetController = null;
        } else if (state is CartLoaded &&
            state.cartItems.isNotEmpty &&
            _sheetController == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showCheckoutBottomSheet(context);
          });
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                title: Row(
                  children: [
                    Text("cart".tr()),
                    if (state is CartLoaded && state.totalItems > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${state.totalItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 2,
                shadowColor: Colors.black.withAlpha(10),
                surfaceTintColor: Colors.transparent,
                pinned: true,
              ),
              if (state is CartLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (state is CartLoaded && state.cartItems.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart,
                            size: 55, color: Colors.grey),
                        const SizedBox(height: 10),
                        Text("your_cart_empty".tr()),
                        Text("add_products_to_start".tr()),
                      ],
                    ),
                  ),
                )
              else if (state is CartLoaded) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final cartItem = state.cartItems[index];
                        return Column(
                          children: [
                            _buildCartItem(context, cartItem),
                            const Divider(),
                          ],
                        );
                      },
                      childCount: state.cartItems.length,
                    ),
                  ),
                ),
              ] else
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text("something_went_wrong".tr()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    final product = cartItem.product;
    final quantity = cartItem.quantity;

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.images.isNotEmpty
              ? product.images.first
              : product.category.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 50,
            height: 50,
            color: Colors.grey[300],
            child: const Icon(Icons.image_not_supported),
          ),
        ),
      ),
      title: Text(
        product.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.category.name,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "\$${cartItem.totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              if (quantity > 1) {
                context.read<CartCubit>().updateQuantity(product, quantity - 1);
              } else {
                context.read<CartCubit>().removeFromCart(product);
              }
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              context.read<CartCubit>().updateQuantity(product, quantity + 1);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              context.read<CartCubit>().removeFromCart(product);
              showWarningToast(
                  context: context,
                  message: "${product.title} was removed from cart");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${state.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${state.totalItems} item${state.totalItems > 1 ? 's' : ''} in cart',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomActionSlider(
              onSuccess: () async => _showCheckoutDialog(context, state),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCheckoutDialog(
      BuildContext context, CartLoaded state) async {
    final shouldCheckout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("confirm_checkout".tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "confirm_checkout_question".tr(),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "order_summary".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("items_count".tr(args: [state.totalItems.toString()])),
                  Text("total_amount"
                      .tr(args: [state.totalAmount.toStringAsFixed(2)])),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "cart_cleared_after_checkout".tr(),
              style: TextStyle(
                color: Colors.orange,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("cancel".tr()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              "confirm_checkout".tr(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (shouldCheckout == true && context.mounted) {
      try {
        final orderId = await OrderService.placeOrder(
          state.cartItems,
          state.totalAmount,
        );

        if (context.mounted) {
          context.read<CartCubit>().clearCart();
          if (NotificationService.permissionGranted ==
              getIt<NotificationCubit>().isNotificationEnabled) {
            context.read<NotificationCubit>().setNotificationScreenOpen(false);
            context.read<NotificationCubit>().incrementNotificationBadge();
            await NotificationService.showNotification(
              title: 'order_confirmed'.tr(),
              body: 'order_confirmation_message'
                  .tr(args: [orderId.substring(orderId.length - 8)]),
            );
          } else {
            showErrorToast(
                context: context, message: "enable_notifications".tr());
          }

          if (context.mounted) {
            showSuccessToast(
                context: context,
                message: "order_placed_successfully"
                    .tr(args: [orderId.substring(orderId.length - 8)]));
          }
        }
      } catch (e) {
        if (context.mounted) {
          showErrorToast(
              context: context, message: "Failed to place order: $e");
        }
      }
    }
  }
}
