import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/cart_item.dart';
import '../data/models/product_model.dart';

class CartService {
  static final List<CartItem> _cartItems = [];
  static const String _cartKey = 'user_cart';

  static List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  static Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);

      if (cartJson != null) {
        final cartList = jsonDecode(cartJson) as List;
        _cartItems.clear();
        _cartItems.addAll(
          cartList.map((cartJson) => CartItem.fromJson(cartJson)).toList(),
        );
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  static Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = jsonEncode(
        _cartItems.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  static Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    try {
      // Check if product already exists in cart
      final existingIndex = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (existingIndex != -1) {
        // Update quantity if product already exists
        _cartItems[existingIndex].quantity += quantity;
      } else {
        // Add new item to cart
        _cartItems.add(CartItem(product: product, quantity: quantity));
      }

      await _saveCart();
    } catch (e) {
      debugPrint('Error adding to cart: $e');
      throw Exception('Failed to add item to cart');
    }
  }

  static Future<void> removeFromCart(ProductModel product) async {
    try {
      _cartItems.removeWhere((item) => item.product.id == product.id);
      await _saveCart();
    } catch (e) {
      debugPrint('Error removing from cart: $e');
      throw Exception('Failed to remove item from cart');
    }
  }

  static Future<void> updateQuantity(ProductModel product, int newQuantity) async {
    try {
      if (newQuantity <= 0) {
        await removeFromCart(product);
        return;
      }

      final index = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (index != -1) {
        _cartItems[index].quantity = newQuantity;
        await _saveCart();
      }
    } catch (e) {
      debugPrint('Error updating quantity: $e');
      throw Exception('Failed to update quantity');
    }
  }

  static Future<void> clearCart() async {
    try {
      _cartItems.clear();
      await _saveCart();
    } catch (e) {
      debugPrint('Error clearing cart: $e');
      throw Exception('Failed to clear cart');
    }
  }

  static double get totalAmount {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  static int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  static bool isInCart(ProductModel product) {
    return _cartItems.any((item) => item.product.id == product.id);
  }

  static int getQuantityInCart(ProductModel product) {
    final cartItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    return cartItem.quantity;
  }
}
