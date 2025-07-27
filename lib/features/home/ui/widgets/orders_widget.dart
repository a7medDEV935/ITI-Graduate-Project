import 'package:final_project/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/widgets/custom_pull_to_refresh.dart';
import '../../../../core/widgets/toast.dart';
import '../../data/models/order_model.dart';
import '../../service/order_service.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOrders();
    });
  }

  void _showClearOrdersDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('clear_all_orders'.tr()),
          content: Text('clear_orders_confirm'.tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                OrderService.clearOrders().then((_) {
                  setState(() {});
                  if (context.mounted) {
                    showWarningToast(
                        context: context, message: 'all_orders_cleared'.tr());
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('clear_all'.tr()),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadOrders() async {
    await OrderService.loadOrders();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _loadOrders,
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: Text('My Orders'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 2,
              shadowColor: Colors.black.withAlpha(10),
              surfaceTintColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                if (OrderService.orders.isNotEmpty)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (value) {
                      if (value == 'clear_all') {
                        _showClearOrdersDialog();
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'clear_all',
                        child: Row(
                          children: [
                            Icon(Icons.clear_all, color: Colors.red),
                            SizedBox(width: 8),
                            Text('clear_all_orders'.tr()),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
              pinned: true,
            ),
            OrderService.orders.isEmpty
                ? SliverToBoxAdapter(child: _buildEmptyOrders(context, theme))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: _buildOrdersStats(theme),
                          );
                        }
                        final order = OrderService.orders[index - 1];
                        return PullToRefresh(
                          onRefresh: _loadOrders,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: _buildOrderCard(order, theme),
                          ),
                        );
                      },
                      childCount: OrderService.orders.length + 1,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyOrders(BuildContext context, ThemeData theme) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.7,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No orders yet',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start shopping to see your orders here',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildOrderCard(Order order, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.secondary,
          child: const Icon(Icons.receipt, color: Colors.white, size: 20),
        ),
        title: Text(
          'Order #${order.id.substring(order.id.length - 8)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.orderDate.toHumanized(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(10),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withAlpha(30)),
                  ),
                  child: Text(
                    order.status,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${order.totalAmount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Items (${order.items.length})',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...order.items.map((item) => _buildOrderItem(item, theme)),
                if (order.deliveryAddress != null) ...[
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    'Delivery Address:',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.deliveryAddress!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.productImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                width: 50,
                height: 50,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Qty: ${item.quantity} × \$${item.productPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${item.totalPrice.toStringAsFixed(2)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersStats(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Total Orders',
              '${OrderService.totalOrders}',
              Icons.shopping_bag,
              theme,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.colorScheme.primary.withAlpha(30),
          ),
          Expanded(
            child: _buildStatItem(
              'Total Spent',
              '\$${OrderService.totalSpent.toStringAsFixed(2)}',
              Icons.attach_money,
              theme,
            ),
          ),
        ],
      ),
    );
  }
}
