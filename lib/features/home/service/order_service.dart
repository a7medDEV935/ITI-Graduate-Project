import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/order_model.dart';
import '../data/models/cart_item.dart';

class OrderService {
  static final List<Order> _orders = [];
  static const String _ordersKey = 'user_orders';

  static List<Order> get orders => List.unmodifiable(_orders);

  static Future<void> loadOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString(_ordersKey);

      if (ordersJson != null) {
        final ordersList = jsonDecode(ordersJson) as List;
        _orders.clear();
        _orders.addAll(
          ordersList.map((orderJson) => Order.fromJson(orderJson)).toList(),
        );

        _orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
      }
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
  }

  static Future<void> _saveOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = jsonEncode(
        _orders.map((order) => order.toJson()).toList(),
      );
      await prefs.setString(_ordersKey, ordersJson);
    } catch (e) {
      debugPrint('Error saving orders: $e');
    }
  }

  static Future<String> placeOrder(
    List<CartItem> cartItems,
    double totalAmount, {
    String? deliveryAddress,
  }) async {
    try {
      final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';

      final orderItems = cartItems.map((cartItem) {
        return OrderItem(
          productId: cartItem.product.id,
          productName: cartItem.product.title,
          productImage: cartItem.product.images.isNotEmpty
              ? cartItem.product.images.first
              : cartItem.product.category.image,
          productPrice: cartItem.product.price,
          quantity: cartItem.quantity,
          totalPrice: cartItem.totalPrice,
        );
      }).toList();

      final order = Order(
        id: orderId,
        orderDate: DateTime.now(),
        items: orderItems,
        totalAmount: totalAmount,
        status: 'Completed',
        deliveryAddress: deliveryAddress,
      );

      _orders.insert(0, order);
      await _saveOrders();

      return orderId;
    } catch (e) {
      debugPrint('Error placing order: $e');
      throw Exception('Failed to place order');
    }
  }

  static Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (_) {
      return null;
    }
  }

  static List<Order> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  static double get totalSpent {
    return _orders.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  static int get totalOrders => _orders.length;

  static Future<void> clearOrders() async {
    _orders.clear();
    await _saveOrders();
  }
}
