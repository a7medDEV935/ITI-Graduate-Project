import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../data/models/product_model.dart';
import '../enums/sort_by_enum.dart';
import '../logic/cart/cart_cubit.dart';
import '../service/product_filter_service.dart';
import 'poduct_detail_page.dart';
import 'widgets/product_card_grid_tile.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;
  final List<ProductModel> products;

  const CategoryProductsScreen({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  SortBy _selectedSort = SortBy.aToZ;

  List<ProductModel> get _filteredProducts {
    final filter = ProductFilter(sortBy: _selectedSort);
    // Filter out hidden/inactive products even for admin users in category screens
    final visibleProducts = widget.products.where((product) {
      final isProductActive = product.active ?? true;
      final isProductHidden = product.hidden ?? false;
      final isCategoryActive = product.category.active ?? true;
      final isCategoryHidden = product.category.hidden ?? false;

      return isProductActive &&
          !isProductHidden &&
          isCategoryActive &&
          !isCategoryHidden;
    }).toList();

    return filter.filterAndSort(visibleProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: Text(widget.category),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 2,
              shadowColor: Colors.black.withAlpha(10),
              surfaceTintColor: Colors.transparent,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore Items',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: DropdownButton<SortBy>(
                        value: _selectedSort,
                        onChanged: (SortBy? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSort = newValue;
                            });
                          }
                        },
                        items: SortBy.values.map(
                          (sort) {
                            return DropdownMenuItem(
                              value: sort,
                              child: Text(sort.label),
                            );
                          },
                        ).toList(),
                        underline: const SizedBox.shrink(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        icon: const Icon(Icons.sort, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(5),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: getIt<CartCubit>(),
                              child:
                                  RelatedProductsDetailPage(product: product),
                            ),
                          ),
                        );
                      },
                      child: ProductCardGridTile(product: product),
                    );
                  },
                  childCount: _filteredProducts.length,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
