import 'package:carousel_slider/carousel_slider.dart';
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
import 'build_category_card.dart';
import 'product_card_grid_tile.dart';
import 'product_card_list_tile.dart';
import 'product_search_delegate.dart';

class HomeWidgetSuccess extends StatefulWidget {
  const HomeWidgetSuccess({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<HomeWidgetSuccess> createState() => _HomeWidgetSuccessState();
}

class _HomeWidgetSuccessState extends State<HomeWidgetSuccess> {
  final ValueNotifier<ViewMode> _viewModeNotifier =
      ValueNotifier(ViewMode.grid);
  Map<String, List<ProductModel>> groupedByCategory = {};
  List<String> _categoryKeys = [];

  SortBy _selectedSort = SortBy.aToZ;

  List<ProductModel> get _filteredProducts {
    final filter = ProductFilter(sortBy: _selectedSort);
    // Always filter out hidden/inactive products and categories for the home screen
    // regardless of user type (admin or regular user)
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

  void _groupProductsByCategory() {
    groupedByCategory.clear();

    // Debug: Print filtering information
    // print('=== Grouping Products by Category ===');
    // print('Total filtered products: ${_filteredProducts.length}');

    for (var product in _filteredProducts) {
      final categoryName = product.category.name;

      // Debug: Print product and category status
      // print('Product: ${product.title}');
      // print('  Category: $categoryName');
      // print( '  Product active: ${product.active ?? true}, hidden: ${product.hidden ?? false}');
      // print('  Category active: ${product.category.active ?? true}, hidden: ${product.category.hidden ?? false}');

      groupedByCategory.putIfAbsent(categoryName, () => []);
      groupedByCategory[categoryName]!.add(product);
    }
    _categoryKeys = groupedByCategory.keys.toList();

    // print('Categories with products: ${_categoryKeys.join(', ')}');
    // print('=== End Grouping ===');
  }

  final List<Map<String, dynamic>> categoryIcons = [
    {
      'name': 'Electronics',
      'icon': Icons.electrical_services,
      'color': Colors.blue,
    },
    {
      'name': 'Clothes',
      'icon': Icons.checkroom,
      'color': Colors.pink,
    },
    {
      'name': 'Furniture',
      'icon': Icons.chair,
      'color': Colors.green,
    },
    {
      'name': 'Shoes',
      'icon': Icons.hiking,
      'color': Colors.orange,
    },
    {
      'name': 'Miscellaneous',
      'icon': Icons.category,
      'color': Colors.brown,
    },
    {
      'name': 'Books',
      'icon': Icons.book,
      'color': Colors.deepPurple,
    },
    {
      'name': 'Toys',
      'icon': Icons.toys,
      'color': Colors.redAccent,
    },
    {
      'name': 'Beauty',
      'icon': Icons.brush,
      'color': Colors.purple,
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_soccer,
      'color': Colors.teal,
    },
    {
      'name': 'Groceries',
      'icon': Icons.local_grocery_store,
      'color': Colors.lightGreen,
    },
    {
      'name': 'Watches',
      'icon': Icons.watch,
      'color': Colors.indigo,
    },
    {
      'name': 'Jewelry',
      'icon': Icons.diamond,
      'color': Colors.amber,
    },
  ];

  @override
  void initState() {
    super.initState();
    _groupProductsByCategory();
  }

  @override
  void didUpdateWidget(HomeWidgetSuccess oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.products != widget.products) {
      _groupProductsByCategory();
    }
  }

  @override
  void dispose() {
    _viewModeNotifier.dispose();
    super.dispose();
  }

  void _navigateToRelatedProducts(
      BuildContext context, ProductModel selectedProduct) {
    try {
      final categoryName = selectedProduct.category.name;
      final relatedProducts = groupedByCategory[categoryName]
              ?.where((p) => p.id != selectedProduct.id)
              .toList() ??
          [];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<CartCubit>(),
            child: ProductDetailPage(
              relatedProducts: relatedProducts,
              product: selectedProduct,
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.medium(
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            shadowColor: Colors.black.withAlpha(10),
            surfaceTintColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.storefront,
                      color: Colors.deepPurple,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Shopify',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                    ),
                  ],
                ),
                _buildViewToggleButton(),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ProductSearchDelegate(
                      allProducts: widget.products,
                      groupedByCategory: groupedByCategory,
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                'Shop by Category',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _categoryKeys.length,
                itemBuilder: (context, index) {
                  final key = _categoryKeys[index];
                  final iconData = categoryIcons.firstWhere(
                    (element) => element['name'] == key,
                    orElse: () => {
                      'name': key,
                      'icon': Icons.category,
                      'color': Colors.grey,
                    },
                  );
                  return buildCategoryCard(
                    context,
                    category: iconData,
                    products: groupedByCategory[key] ?? [],
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: CarouselSlider(
                items: widget.products
                    .map((product) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product.images.isNotEmpty
                                ? product.images.first
                                : '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.85,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.15,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: ValueListenableBuilder<ViewMode>(
                valueListenable: _viewModeNotifier,
                builder: (context, viewMode, _) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured Products',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
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
                                  _groupProductsByCategory(); // Regroup categories after sort change
                                });
                              }
                            },
                            items: SortBy.values.map((sort) {
                              return DropdownMenuItem(
                                value: sort,
                                child: Text(sort.label),
                              );
                            }).toList(),
                            underline: const SizedBox.shrink(),
                            style: Theme.of(context).textTheme.bodyMedium,
                            icon: const Icon(Icons.sort, size: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          ValueListenableBuilder<ViewMode>(
            valueListenable: _viewModeNotifier,
            builder: (context, viewMode, _) {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: viewMode == ViewMode.list
                    ? SliverList(
                        key: const ValueKey('list_view'),
                        delegate: SliverChildBuilderDelegate(
                          childCount: _filteredProducts.length,
                          (context, index) {
                            final product = _filteredProducts[index];
                            return TweenAnimationBuilder<double>(
                              duration:
                                  Duration(milliseconds: 300 + (index * 50)),
                              tween: Tween(begin: 0.0, end: 1.0),
                              curve: Curves.easeOutBack,
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Opacity(
                                    opacity: value.clamp(0.0, 1.0),
                                    child: child,
                                  ),
                                );
                              },
                              child: GestureDetector(
                                onTap: () => _navigateToRelatedProducts(
                                    context, product),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ProductCardListTile(product: product),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SliverGrid(
                        key: const ValueKey('grid_view'),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = _filteredProducts[index];
                            return TweenAnimationBuilder<double>(
                              duration:
                                  Duration(milliseconds: 300 + (index * 30)),
                              tween: Tween(begin: 0.0, end: 1.0),
                              curve: Curves.easeOutBack,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: 0.8 + (0.2 * value),
                                  child: Opacity(
                                    opacity: value.clamp(0.0, 1.0),
                                    child: child,
                                  ),
                                );
                              },
                              child: GestureDetector(
                                onTap: () => _navigateToRelatedProducts(
                                    context, product),
                                child: ProductCardGridTile(product: product),
                              ),
                            );
                          },
                          childCount: _filteredProducts.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.6,
                        ),
                      ),
              );
            },
          ),
          // SliverList.builder(
          //   itemBuilder: (context, idx) => Text(idx.toString()),
          //   itemCount: 20,
          // )
        ],
      ),
    );
  }

  Widget _buildViewToggleButton() {
    return ValueListenableBuilder<ViewMode>(
      valueListenable: _viewModeNotifier,
      builder: (context, viewMode, _) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: viewMode == ViewMode.grid
              ? Colors.deepPurple.withAlpha(10)
              : Colors.blue.withAlpha(10),
        ),
        child: IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(
                turns: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            child: Icon(
              viewMode == ViewMode.grid
                  ? Icons.view_list_rounded
                  : Icons.grid_view_rounded,
              key: ValueKey(viewMode),
              color:
                  viewMode == ViewMode.grid ? Colors.deepPurple : Colors.blue,
            ),
          ),
          onPressed: () {
            // Add haptic feedback for better UX
            if (Theme.of(context).platform == TargetPlatform.iOS) {
              // Light impact for iOS
            }
            _viewModeNotifier.value =
                viewMode == ViewMode.grid ? ViewMode.list : ViewMode.grid;
          },
          tooltip: viewMode == ViewMode.grid
              ? 'Switch to List View'
              : 'Switch to Grid View',
        ),
      ),
    );
  }
}
