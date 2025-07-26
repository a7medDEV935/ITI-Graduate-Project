import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/firestore_service.dart';
import '../../data/repo/product_repo.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  bool _hasFetched = false;
  final ProductRepo _productRepo;

  ProductsCubit(this._productRepo) : super(ProductsState.initial());

  Future<void> fetchProducts() async {
    if (_hasFetched || isClosed) return;

    emit(const ProductsState.loading());
    await Future.delayed(const Duration(seconds: 2));

    final response = await _productRepo.fetchProducts();

    await response.when(
      success: (data) async {
        _hasFetched = true;
        final List<Map<String, dynamic>> productDataList =
            data.map((product) => product.toJson()).toList();
        await FirestoreService.addDocumentsBatch(
          'products',
          productDataList,
          useCustomId: true,
        );
        emit(ProductsState.success(data));
      },
      failure: (error) {
        emit(ProductsState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong'));
      },
    );
  }

  Future<void> refreshProducts() async {
    if (isClosed) return;

    emit(const ProductsState.loading());
    await Future.delayed(const Duration(seconds: 2));

    final response = await getIt<ProductRepo>().fetchProducts();

    await response.when(
      success: (data) async {
        _hasFetched = true;
        final List<Map<String, dynamic>> productDataList =
            data.map((product) => product.toJson()).toList();
        await FirestoreService.addDocumentsBatch(
          'products',
          productDataList,
          useCustomId: true,
        );
        emit(ProductsState.success(data));
      },
      failure: (error) {
        emit(ProductsState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong'));
      },
    );
  }

  void listenToFirestoreProducts() {
    emit(const ProductsState.loading());

    FirestoreService.getProductsTyped().listen((products) {
      emit(ProductsState.success(products));
    }, onError: (error) {
      emit(ProductsState.error(error: error.toString()));
    });
  }
}
