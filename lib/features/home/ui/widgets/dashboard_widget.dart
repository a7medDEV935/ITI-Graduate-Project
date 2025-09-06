import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/admin_service.dart';
import '../../../../core/widgets/toast.dart';
import '../../data/models/product_model.dart';
import '../../logic/products/products_cubit.dart';
import '../../logic/products/products_state.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({super.key});

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final ProductsCubit _cubit;
  List<ProductModel> products = [];
  Map<String, List<ProductModel>> groupedByCategory = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _cubit = getIt<ProductsCubit>();
    _cubit.listenToFirestoreProducts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _groupProductsByCategory() {
    groupedByCategory.clear();
    for (var product in products) {
      final categoryName = product.category.name;
      groupedByCategory.putIfAbsent(categoryName, () => []);
      groupedByCategory[categoryName]!.add(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'admin_dashboard'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            tabs: [
              Tab(
                icon: const Icon(Icons.category),
                text: 'categories'.tr(),
              ),
              Tab(
                icon: const Icon(Icons.inventory),
                text: 'products'.tr(),
              ),
            ],
          ),
        ),
        body: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (fetchedProducts) {
                setState(() {
                  products = fetchedProducts;
                  _groupProductsByCategory();
                });
              },
              error: (error) {
                showErrorToast(context: context, message: 'Error: $error');
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => Center(
                child: Text('welcome_to_admin_dashboard'.tr()),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (fetchedProducts) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCategoriesTab(),
                    _buildProductsTab(),
                  ],
                );
              },
              error: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'error_with_message'.tr(args: [error]),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _cubit.refreshProducts();
                      },
                      child: Text('retry'.tr()),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoriesTab() {
    if (groupedByCategory.isEmpty) {
      return Center(
        child: Text(
          'no_categories_available'.tr(),
          style: const TextStyle(fontSize: 18),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final categoryName = groupedByCategory.keys.elementAt(index);
                final categoryProducts = groupedByCategory[categoryName]!;
                final category = categoryProducts.first.category;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 4,
                  child: ExpansionTile(
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(category.image),
                          onBackgroundImageError: (_, __) {},
                          child: category.image.isEmpty
                              ? Icon(Icons.category,
                                  color: Theme.of(context).colorScheme.primary)
                              : null,
                        ),
                        // Status indicator
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: _buildStatusIndicator(category),
                        ),
                      ],
                    ),
                    title: Text(
                      categoryName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'products_count'
                          .tr(args: [categoryProducts.length.toString()]),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        _handleCategoryAction(value, category, categoryName);
                      },
                      itemBuilder: (context) {
                        // Use the actual properties from the category object
                        final isHidden = category.hidden ?? false;
                        final isActive = category.active ?? true;

                        return [
                          PopupMenuItem(
                            value: isHidden ? 'show' : 'hide',
                            child: Row(
                              children: [
                                Icon(
                                  isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(isHidden ? 'show'.tr() : 'hide'.tr()),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: isActive ? 'deactivate' : 'activate',
                            child: Row(
                              children: [
                                Icon(
                                  isActive ? Icons.block : Icons.check_circle,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(isActive
                                    ? 'deactivate'.tr()
                                    : 'activate'.tr()),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete,
                                    size: 20, color: Colors.red),
                                const SizedBox(width: 8),
                                Text('delete'.tr(),
                                    style: const TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category Details:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow('ID', category.id.toString()),
                            _buildDetailRow('Slug', category.slug),
                            _buildDetailRow(
                                'Created', _formatDate(category.creationAt)),
                            _buildDetailRow(
                                'Updated', _formatDate(category.updatedAt)),
                            const SizedBox(height: 12),
                            Text(
                              'Products in this category:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...categoryProducts.take(3).map(
                                  (product) => Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withAlpha(10),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '• ${product.title}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                  ),
                                ),
                            if (categoryProducts.length > 3)
                              Text(
                                '... and ${categoryProducts.length - 3} more',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: groupedByCategory.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsTab() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total Products: ${products.length}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddProductDialog,
                  icon: const Icon(Icons.add),
                  label: Text('add_product'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: products.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'no_products_available'.tr(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = products[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.images.isNotEmpty
                                  ? product.images.first
                                  : '',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(10),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.image_not_supported,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildProductStatusIndicator(product),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Category: ${product.category.name}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) {
                              _handleProductAction(value, product);
                            },
                            itemBuilder: (context) {
                              // Use the actual properties from the product object
                              final isHidden = product.hidden ?? false;
                              final isActive = product.active ?? true;

                              return [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.edit, size: 20),
                                      const SizedBox(width: 8),
                                      Text('edit'.tr()),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: isHidden ? 'show' : 'hide',
                                  child: Row(
                                    children: [
                                      Icon(
                                        isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                          isHidden ? 'show'.tr() : 'hide'.tr()),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: isActive ? 'deactivate' : 'activate',
                                  child: Row(
                                    children: [
                                      Icon(
                                        isActive
                                            ? Icons.block
                                            : Icons.check_circle,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(isActive
                                          ? 'deactivate'.tr()
                                          : 'activate'.tr()),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      const Icon(Icons.delete,
                                          size: 20, color: Colors.red),
                                      const SizedBox(width: 8),
                                      Text('delete'.tr(),
                                          style: const TextStyle(
                                              color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                          onTap: () => _showProductDetails(product),
                        ),
                      );
                    },
                    childCount: products.length,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(Category category) {
    // Use the actual properties from the category object
    final isHidden = category.hidden ?? false;
    final isActive = category.active ?? true;

    // Debug: Print category status
    // print('Building status indicator for ${category.name}: hidden=$isHidden, active=$isActive');

    if (isHidden) {
      return Container(
        width: 16,
        height: 16,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.visibility_off,
          size: 10,
          color: Colors.white,
        ),
      );
    } else if (!isActive) {
      return Container(
        width: 16,
        height: 16,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.block,
          size: 10,
          color: Colors.white,
        ),
      );
    }

    return Container(
      width: 16,
      height: 16,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        size: 10,
        color: Colors.white,
      ),
    );
  }

  Widget _buildProductStatusIndicator(ProductModel product) {
    // Use the actual properties from the product object
    final isHidden = product.hidden ?? false;
    final isActive = product.active ?? true;

    if (isHidden) {
      return const Icon(
        Icons.visibility_off,
        size: 16,
        color: Colors.orange,
      );
    } else if (!isActive) {
      return const Icon(
        Icons.block,
        size: 16,
        color: Colors.grey,
      );
    }

    return const Icon(
      Icons.check_circle,
      size: 16,
      color: Colors.green,
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _handleCategoryAction(
      String action, Category category, String categoryName) {
    // Debug: Print current category state
    // print('Category Action: $action for $categoryName');
    // print('Current category state - hidden: ${category.hidden}, active: ${category.active}');

    switch (action) {
      case 'hide':
        _showActionDialog(
          title: 'Hide Category',
          content:
              'Are you sure you want to hide the "$categoryName" category? This will hide all products in this category from regular users.',
          action: () async {
            try {
              // print('Hiding category: $categoryName');
              await AdminService.hideCategory(categoryName);
              if (mounted) {
                showWarningToast(
                    context: context,
                    message: 'Category "$categoryName" hidden successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              // print('Error hiding category: $e');
              if (mounted) {
                showErrorToast(
                    context: context, message: 'Failed to hide category: $e');
              }
            }
          },
        );
        break;
      case 'show':
        _showActionDialog(
          title: 'Show Category',
          content:
              'Are you sure you want to show the "$categoryName" category? This will make all products in this category visible to regular users.',
          action: () async {
            try {
              // print('Showing category: $categoryName');
              await AdminService.showCategory(categoryName);
              if (mounted) {
                showSuccessToast(
                    context: context,
                    message: 'Category "$categoryName" shown successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              // print('Error showing category: $e');
              if (mounted) {
                showErrorToast(
                    context: context, message: 'Failed to show category: $e');
              }
            }
          },
        );
        break;
      case 'deactivate':
        _showActionDialog(
          title: 'Deactivate Category',
          content:
              'Are you sure you want to deactivate the "$categoryName" category? This will deactivate all products in this category.',
          action: () async {
            try {
              // print('Deactivating category: $categoryName');
              await AdminService.deactivateCategory(categoryName);
              if (mounted) {
                showInfoToast(
                    context: context,
                    message:
                        'Category "$categoryName" deactivated successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              // print('Error deactivating category: $e');
              if (mounted) {
                showErrorToast(
                    context: context,
                    message: 'Failed to deactivate category: $e');
              }
            }
          },
        );
        break;
      case 'activate':
        _showActionDialog(
          title: 'Activate Category',
          content:
              'Are you sure you want to activate the "$categoryName" category? This will activate all products in this category.',
          action: () async {
            try {
              // print('Activating category: $categoryName');
              await AdminService.activateCategory(categoryName);
              if (mounted) {
                showSuccessToast(
                    context: context,
                    message: 'Category "$categoryName" activated successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              // print('Error activating category: $e');
              if (mounted) {
                showErrorToast(
                    context: context,
                    message: 'Failed to activate category: $e');
              }
            }
          },
        );
        break;
      case 'delete':
        _showActionDialog(
          title: 'Delete Category',
          content:
              'Are you sure you want to delete the "$categoryName" category? This will permanently delete all products in this category. This action cannot be undone.',
          action: () async {
            try {
              await AdminService.deleteCategory(categoryName);
              if (mounted) {
                showSuccessToast(
                    context: context,
                    message: 'Category "$categoryName" deleted successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              if (mounted) {
                showErrorToast(
                    context: context, message: 'Failed to delete category: $e');
              }
            }
          },
          isDestructive: true,
        );
        break;
    }
  }

  void _handleProductAction(String action, ProductModel product) {
    switch (action) {
      case 'edit':
        _showEditProductDialog(product);
        break;
      case 'hide':
        _showActionDialog(
          title: 'Hide Product',
          content:
              'Are you sure you want to hide "${product.title}"? This will hide the product from regular users.',
          action: () async {
            try {
              await AdminService.hideProduct(product.id);
              if (mounted) {
                showWarningToast(
                    context: context,
                    message: 'Product "${product.title}" hidden successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              if (mounted) {
                showErrorToast(
                    context: context, message: 'Failed to hide product: $e');
              }
            }
          },
        );
        break;
      case 'show':
        _showActionDialog(
          title: 'Show Product',
          content:
              'Are you sure you want to show "${product.title}"? This will make the product visible to regular users.',
          action: () async {
            try {
              await AdminService.showProduct(product.id);
              if (mounted) {
                showSuccessToast(
                    context: context,
                    message: 'Product "${product.title}" shown successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              if (mounted) {
                showErrorToast(
                    context: context, message: 'Failed to show product: $e');
              }
            }
          },
        );
        break;
      case 'deactivate':
        _showActionDialog(
          title: 'Deactivate Product',
          content:
              'Are you sure you want to deactivate "${product.title}"? This will make the product inactive.',
          action: () async {
            try {
              await AdminService.deactivateProduct(product.id);
              if (mounted) {
                showWarningToast(
                    context: context,
                    message:
                        'Product "${product.title}" deactivated successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              if (mounted) {
                showErrorToast(
                    context: context,
                    message: 'Failed to deactivate product: $e');
              }
            }
          },
        );
        break;
      case 'activate':
        _showActionDialog(
          title: 'Activate Product',
          content:
              'Are you sure you want to activate "${product.title}"? This will make the product active.',
          action: () async {
            try {
              await AdminService.activateProduct(product.id);
              if (mounted) {
                showSuccessToast(
                    context: context,
                    message:
                        'Product "${product.title}" activated successfully');
              }
              // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              if (mounted) {
                showErrorToast(
                    context: context,
                    message: 'Failed to activate product: $e');
              }
            }
          },
        );
        break;
      case 'delete':
        _showActionDialog(
          title: 'Delete Product',
          content:
              'Are you sure you want to delete "${product.title}"? This action cannot be undone.',
          action: () async {
            try {
              await AdminService.deleteProduct(product.id);
              if (mounted) {
                showSuccessToast(
                    context: context,
                    message: 'Product "${product.title}" deleted successfully');
              } // Refresh the products list
              _cubit.listenToFirestoreProducts();
            } catch (e) {
              if (mounted) {
                showErrorToast(
                    context: context, message: 'Failed to delete product: $e');
              }
            }
          },
          isDestructive: true,
        );
        break;
    }
  }

  void _showActionDialog({
    required String title,
    required String content,
    required Future<void> Function() action,
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                // Check if widget is still mounted before showing loading
                if (!mounted) return;

                // Show loading indicator with the widget's context
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (loadingContext) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                try {
                  await action();
                } finally {
                  // Hide loading indicator only if widget is still mounted
                  if (mounted && Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDestructive ? Colors.red : null,
                foregroundColor: isDestructive ? Colors.white : null,
              ),
              child: Text(isDestructive ? 'delete'.tr() : 'confirm'.tr()),
            ),
          ],
        );
      },
    );
  }

  void _showAddProductDialog() {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    String? selectedCategory;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('add_new_product'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'product_title'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'price'.tr(),
                    border: const OutlineInputBorder(),
                    prefixText: '\$',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'category'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: groupedByCategory.keys.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'description'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    priceController.text.isNotEmpty &&
                    selectedCategory != null) {
                  Navigator.of(context).pop();

                  // Check if widget is still mounted before showing loading
                  if (!mounted) return;

                  // Show loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  try {
                    final price = double.tryParse(priceController.text) ?? 0.0;

                    await AdminService.addProduct(
                      title: titleController.text,
                      price: price,
                      description: descriptionController.text,
                      categoryName: selectedCategory!,
                    );

                    // Hide loading indicator
                    if (context.mounted && Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }

                    if (context.mounted) {
                      showSuccessToast(
                          context: context,
                          message: 'Product added successfully');
                    }

                    // Refresh the products list
                    _cubit.listenToFirestoreProducts();
                  } catch (e) {
                    // Hide loading indicator
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }

                    if (context.mounted) {
                      showErrorToast(
                          context: context,
                          message: 'failed_to_add_product'.tr());
                    }
                  }
                } else {
                  if (mounted) {
                    showErrorToast(
                        context: context,
                        message: 'please_fill_all_fields'.tr());
                  }
                }
              },
              child: Text('add_product'.tr()),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(ProductModel product) {
    final titleController = TextEditingController(text: product.title);
    final priceController =
        TextEditingController(text: product.price.toString());
    final descriptionController =
        TextEditingController(text: product.description);
    String selectedCategory = product.category.name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('edit_product'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'product_title'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'price'.tr(),
                    border: const OutlineInputBorder(),
                    prefixText: '\$',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'category'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: groupedByCategory.keys.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) selectedCategory = value;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'description'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // Check if widget is still mounted before showing loading
                if (!mounted) return;

                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                try {
                  final price =
                      double.tryParse(priceController.text) ?? product.price;

                  await AdminService.updateProduct(
                    productId: product.id,
                    title: titleController.text.isNotEmpty
                        ? titleController.text
                        : null,
                    price: price != product.price ? price : null,
                    description: descriptionController.text.isNotEmpty
                        ? descriptionController.text
                        : null,
                    categoryName: selectedCategory != product.category.name
                        ? selectedCategory
                        : null,
                  );

                  // Hide loading indicator
                  if (context.mounted && Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }

                  if (context.mounted) {
                    showSuccessToast(
                        context: context,
                        message: 'product_updated_successfully'.tr());
                  }

                  // Refresh the products list
                  _cubit.listenToFirestoreProducts();
                } catch (e) {
                  // Hide loading indicator
                  if (context.mounted && Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }

                  if (context.mounted) {
                    showErrorToast(
                        context: context,
                        message: 'failed_to_update_product'.tr());
                  }
                }
              },
              child: Text('update_product'.tr()),
            ),
          ],
        );
      },
    );
  }

  void _showProductDetails(ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product.title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (product.images.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.images.first,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                _buildDetailRow(
                    'Price', '\$${product.price.toStringAsFixed(2)}'),
                _buildDetailRow('Category', product.category.name),
                _buildDetailRow('ID', product.id.toString()),
                _buildDetailRow('Slug', product.slug),
                _buildDetailRow('Created', _formatDate(product.creationAt)),
                _buildDetailRow('Updated', _formatDate(product.updatedAt)),
                const SizedBox(height: 12),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('close'.tr()),
            ),
          ],
        );
      },
    );
  }
}
