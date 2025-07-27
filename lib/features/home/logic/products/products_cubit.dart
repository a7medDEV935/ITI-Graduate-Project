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
        await _mergeWithExistingFirestoreData(data);
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
        await _mergeWithExistingFirestoreData(data);
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

    // Always get all products (unfiltered) so we can apply our own filtering
    FirestoreService.getProductsTyped().listen((products) {
      emit(ProductsState.success(products));
    }, onError: (error) {
      emit(ProductsState.error(error: error.toString()));
    });
  }

  /// Merges fresh API data with existing Firestore data, preserving admin modifications
  Future<void> _mergeWithExistingFirestoreData(
      List<dynamic> freshProducts) async {
    try {
      // Get existing products from Firestore
      final existingSnapshot =
          await FirestoreService.getCollection('products').first;
      final Map<String, Map<String, dynamic>> existingProducts = {};

      // Build a map of existing products by ID
      for (final doc in existingSnapshot) {
        final id = doc['id']?.toString();
        if (id != null) {
          existingProducts[id] = doc;
        }
      }

      // Prepare products for batch update/insert
      final List<Map<String, dynamic>> productsToUpdate = [];

      for (final product in freshProducts) {
        final productJson = product.toJson();
        final productId = productJson['id']?.toString();

        if (productId != null && existingProducts.containsKey(productId)) {
          // Product exists - preserve admin modifications
          final existing = existingProducts[productId]!;

          // Preserve admin-set fields
          productJson['hidden'] = existing['hidden'] ?? false;
          productJson['active'] = existing['active'] ?? true;

          // Preserve category admin modifications if they exist
          if (productJson['category'] != null && existing['category'] != null) {
            final Map<String, dynamic> category =
                Map<String, dynamic>.from(productJson['category']);
            final Map<String, dynamic> existingCategory =
                Map<String, dynamic>.from(existing['category']);

            category['hidden'] = existingCategory['hidden'] ?? false;
            category['active'] = existingCategory['active'] ?? true;

            productJson['category'] = category;
          }

          // Update the updatedAt timestamp for the fresh data
          productJson['updatedAt'] = DateTime.now().toIso8601String();
        } else {
          // New product - set default admin values
          productJson['hidden'] = false;
          productJson['active'] = true;
          productJson['updatedAt'] = DateTime.now().toIso8601String();

          if (productJson['category'] != null) {
            final Map<String, dynamic> category =
                Map<String, dynamic>.from(productJson['category']);
            category['hidden'] = false;
            category['active'] = true;
            productJson['category'] = category;
          }
        }

        productsToUpdate.add(productJson);
      }

      // Batch update/insert the products
      await FirestoreService.addDocumentsBatch(
        'products',
        productsToUpdate,
        useCustomId: true,
      );

      // print('Successfully merged ${productsToUpdate.length} products while preserving admin modifications');
    } catch (e) {
      // print('Error merging products with existing Firestore data: $e');
      // Fallback to simple batch insert if merge fails
      final List<Map<String, dynamic>> productDataList = freshProducts
          .map((product) => product.toJson() as Map<String, dynamic>)
          .toList();
      await FirestoreService.addDocumentsBatch(
        'products',
        productDataList,
        useCustomId: true,
      );
    }
  }
}
