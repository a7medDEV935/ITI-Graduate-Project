import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../service/cart_service.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> loadCart() async {
    try {
      emit(CartLoading());
      await CartService.loadCart();
      _emitLoadedState();
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    try {
      await CartService.addToCart(product, quantity: quantity);
      _emitLoadedState();
    } catch (e) {
      emit(CartError('Failed to add item to cart: $e'));
    }
  }

  Future<void> removeFromCart(ProductModel product) async {
    try {
      await CartService.removeFromCart(product);
      _emitLoadedState();
    } catch (e) {
      emit(CartError('Failed to remove item from cart: $e'));
    }
  }

  Future<void> updateQuantity(ProductModel product, int newQuantity) async {
    try {
      await CartService.updateQuantity(product, newQuantity);
      _emitLoadedState();
    } catch (e) {
      emit(CartError('Failed to update quantity: $e'));
    }
  }

  Future<void> clearCart() async {
    try {
      await CartService.clearCart();
      _emitLoadedState();
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }

  void _emitLoadedState() {
    emit(CartLoaded(
      cartItems: CartService.cartItems,
      totalAmount: CartService.totalAmount,
      totalItems: CartService.totalItems,
    ));
  }

  bool isInCart(ProductModel product) {
    return CartService.isInCart(product);
  }

  int getQuantityInCart(ProductModel product) {
    return CartService.getQuantityInCart(product);
  }
}
