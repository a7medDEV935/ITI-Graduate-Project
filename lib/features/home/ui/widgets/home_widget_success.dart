import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../auth/data/models/app_user.dart';
import '../../../auth/data/repo/firebase_auth_repo.dart';
import '../../../auth/logic/auth/auth_cubit.dart';
import '../../data/models/product_model.dart';
import '../../service/product_filter_service.dart';
import '../poduct_detail_page.dart';
import 'build_category_card.dart';
import 'product_card.dart';

class HomeWidgetSuccess extends StatefulWidget {
  const HomeWidgetSuccess({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<HomeWidgetSuccess> createState() => _HomeWidgetSuccessState();
}

class _HomeWidgetSuccessState extends State<HomeWidgetSuccess> {
  final Map<String, List<ProductModel>> groupedByCategory = {};
  late final List<String> _categoryKeys;

  SortBy _selectedSort = SortBy.aToZ;

  List<ProductModel> get _filteredProducts {
    final filter = ProductFilter(sortBy: _selectedSort);
    return filter.filterAndSort(widget.products);
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
  ];

  AppUser? currentUser;

  Future<void> loadUser() async {
    final firebaseRepo = getIt<FirebaseRepo>();
    currentUser = await firebaseRepo.getCurrentUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    for (var product in widget.products) {
      final categoryName = product.category.name;
      groupedByCategory.putIfAbsent(categoryName, () => []);
      groupedByCategory[categoryName]!.add(product);
    }
    _categoryKeys = groupedByCategory.keys.toList();
  }

  // customAnimationAppbar(
  //   context: context,
  //   image: currentUser?.photoUrl ?? '',
  //   title: currentUser?.displayName ?? 'Guest',
  //   descripton: currentUser?.email ?? '',
  //   isActions: true,
  //   actions: [
  //     IconButton(
  //       icon: const Icon(Icons.search),
  //       onPressed: () {
  //         // Search action
  //       },
  //     ),
  //     IconButton(
  //       icon: const Icon(Icons.logout),
  //       onPressed: () async {
  //         await context.read<AuthCubit>().logout();
  //       },
  //     ),
  //   ],
  // ),

  void _navigateToRelatedProducts(ProductModel selectedProduct) {
    final categoryName = selectedProduct.category.name;
    final relatedProducts = groupedByCategory[categoryName]!
        .where((p) => p.id != selectedProduct.id)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          relatedProducts: relatedProducts,
          product: selectedProduct,
        ),
      ),
    );
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
              children: [
                const Icon(
                  Icons.storefront,
                  color: Colors.deepPurple,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'Shopify',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () {
                  // Search action
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () async {
                  await context.read<AuthCubit>().logout();
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
                  DropdownButton<SortBy>(
                    value: _selectedSort,
                    onChanged: (SortBy? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSort = newValue;
                        });
                      }
                    },
                    items: SortBy.values.map((sort) {
                      return DropdownMenuItem(
                        value: sort,
                        child: Text(sort.label),
                      );
                    }).toList(),
                    underline: SizedBox.shrink(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _filteredProducts.length,
                (context, index) {
                  final product = _filteredProducts[index];
                  return GestureDetector(
                    onTap: () => _navigateToRelatedProducts(product),
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
