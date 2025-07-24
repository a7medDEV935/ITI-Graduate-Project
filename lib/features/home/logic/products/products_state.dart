import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState<T> with _$ProductsState<T> {
  const factory ProductsState.initial() = _Initial;

  const factory ProductsState.loading() = Loading;
  const factory ProductsState.success(T data) = Success<T>;
  const factory ProductsState.error({required String error}) = Error;
}
