import '../../data/models/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  final double totalAmount;
  final int totalItems;

  CartLoaded({
    required this.cartItems,
    required this.totalAmount,
    required this.totalItems,
  });
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
