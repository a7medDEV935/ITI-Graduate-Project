import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/toast.dart';
import '../../data/models/product_model.dart';
import '../../enums/sort_by_enum.dart';
import '../../enums/view_mode_enum.dart';
import '../../logic/cart/cart_cubit.dart';
import '../../service/product_filter_service.dart';
import '../poduct_detail_page.dart';
import 'product_card_grid_tile.dart';
import 'product_card_list_tile.dart';

class ProductSearchDelegate extends SearchDelegate<ProductModel?> {
  final List<ProductModel> allProducts;
  final Map<String, List<ProductModel>> groupedByCategory;
  final ValueNotifier<ViewMode> _viewModeNotifier =
      ValueNotifier(ViewMode.grid);
  final ValueNotifier<SortBy> _sortNotifier = ValueNotifier(SortBy.aToZ);

  ProductSearchDelegate({
    required this.allProducts,
    required this.groupedByCategory,
  });

  SortBy get _selectedSort => _sortNotifier.value;

  @override
  String get searchFieldLabel => 'Search products by name, category...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: theme.colorScheme.surface,
        iconTheme: theme.iconTheme,
        titleTextStyle: theme.textTheme.titleLarge,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(150),
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
      ValueListenableBuilder<ViewMode>(
        valueListenable: _viewModeNotifier,
        builder: (context, viewMode, _) => IconButton(
          icon: Icon(
            viewMode == ViewMode.grid
                ? Icons.view_list_rounded
                : Icons.grid_view_rounded,
          ),
          onPressed: () {
            _viewModeNotifier.value =
                viewMode == ViewMode.grid ? ViewMode.list : ViewMode.grid;
          },
          tooltip: viewMode == ViewMode.grid
              ? 'Switch to List View'
              : 'Switch to Grid View',
        ),
      ),
      ValueListenableBuilder<SortBy>(
        valueListenable: _sortNotifier,
        builder: (context, currentSort, _) => PopupMenuButton<SortBy>(
          icon: const Icon(Icons.sort),
          tooltip: 'Sort by: ${currentSort.label}',
          onSelected: (SortBy sort) {
            _sortNotifier.value = sort;
          },
          itemBuilder: (context) => SortBy.values.map((sort) {
            return PopupMenuItem<SortBy>(
              value: sort,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(sort.label),
                  if (currentSort == sort)
                    const Icon(Icons.check, size: 16, color: Colors.deepPurple),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder<SortBy>(
      valueListenable: _sortNotifier,
      builder: (context, currentSort, _) {
        final filteredProducts = _getFilteredProducts(currentSort);

        if (filteredProducts.isEmpty && query.isNotEmpty) {
          return _buildEmptyState(context, isNoResults: true);
        }

        return _buildProductList(context, filteredProducts);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder<SortBy>(
      valueListenable: _sortNotifier,
      builder: (context, currentSort, _) {
        if (query.isEmpty) {
          final filter = ProductFilter(sortBy: currentSort);
          final sortedProducts = filter.filterAndSort(allProducts);
          return _buildProductList(context, sortedProducts);
        }

        final suggestions = _getFilteredProducts(currentSort);

        if (suggestions.isEmpty) {
          return _buildEmptyState(context, isNoResults: true);
        }
        return _buildProductList(context, suggestions);
      },
    );
  }

  List<ProductModel> _getFilteredProducts([SortBy? sortBy]) {
    final currentSort = sortBy ?? _selectedSort;
    List<ProductModel> searchResults;

    if (query.isEmpty) {
      searchResults = allProducts;
    } else {
      final searchLower = query.toLowerCase();
      searchResults = allProducts.where((product) {
        return product.title.toLowerCase().contains(searchLower) ||
            product.category.name.toLowerCase().contains(searchLower) ||
            product.description.toLowerCase().contains(searchLower);
      }).toList();
    }
    final filter = ProductFilter(sortBy: currentSort);
    return filter.filterAndSort(searchResults);
  }

  Widget _buildEmptyState(BuildContext context, {required bool isNoResults}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isNoResults ? Icons.search_off : Icons.search,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            isNoResults
                ? 'No products found for "$query"'
                : 'Search for products by name or category',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          if (isNoResults) ...[
            const SizedBox(height: 8),
            Text(
              'Try different keywords or check spelling',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProductList(BuildContext context, List<ProductModel> products) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: Column(
        children: [
          if (query.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withAlpha(50),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withAlpha(50),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${products.length} result${products.length != 1 ? 's' : ''} found for "$query"',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  ValueListenableBuilder<SortBy>(
                    valueListenable: _sortNotifier,
                    builder: (context, currentSort, _) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withAlpha(10),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.deepPurple.withAlpha(50),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        currentSort.label,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ValueListenableBuilder<ViewMode>(
              valueListenable: _viewModeNotifier,
              builder: (context, viewMode, _) {
                if (viewMode == ViewMode.list) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () => _navigateToProductDetail(context, product),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ProductCardListTile(product: product),
                        ),
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () => _navigateToProductDetail(context, product),
                        child: ProductCardGridTile(product: product),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context, ProductModel product) {
    try {
      final categoryName = product.category.name;
      final relatedProducts = groupedByCategory[categoryName]
              ?.where((p) => p.id != product.id)
              .toList() ??
          [];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<CartCubit>(),
            child: ProductDetailPage(
              relatedProducts: relatedProducts,
              product: product,
            ),
          ),
        ),
      );
    } catch (e) {
      showErrorToast(
          context: context, message: 'Error navigating to product details: $e');
    }
  }

  @override
  void dispose() {
    _viewModeNotifier.dispose();
    _sortNotifier.dispose();
    super.dispose();
  }
}
