import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/home/data/models/product_model.dart';
import 'firestore_service.dart';

/// Admin service for managing product and category visibility and status
class AdminService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Product Management
  static Future<void> hideProduct(int productId) async {
    await _updateProductVisibility(productId, hidden: true);
  }

  static Future<void> showProduct(int productId) async {
    await _updateProductVisibility(productId, hidden: false);
  }

  static Future<void> deactivateProduct(int productId) async {
    await _updateProductStatus(productId, active: false);
  }

  static Future<void> activateProduct(int productId) async {
    await _updateProductStatus(productId, active: true);
  }

  static Future<void> deleteProduct(int productId) async {
    await FirestoreService.deleteDocument('products', productId.toString());
  }

  static Future<void> _updateProductVisibility(int productId,
      {required bool hidden}) async {
    // print('Updating product visibility: $productId, hidden: $hidden');
    await FirestoreService.updateDocument(
      'products',
      productId.toString(),
      {'hidden': hidden, 'updatedAt': DateTime.now().toIso8601String()},
    );
    // print('Product visibility update completed');
  }

  static Future<void> _updateProductStatus(int productId,
      {required bool active}) async {
    // print('Updating product status: $productId, active: $active');
    await FirestoreService.updateDocument(
      'products',
      productId.toString(),
      {'active': active, 'updatedAt': DateTime.now().toIso8601String()},
    );
    // print('Product status update completed');
  }

  // Category Management
  static Future<void> hideCategory(String categoryName) async {
    await _updateCategoryVisibility(categoryName, hidden: true);
  }

  static Future<void> showCategory(String categoryName) async {
    await _updateCategoryVisibility(categoryName, hidden: false);
  }

  static Future<void> deactivateCategory(String categoryName) async {
    await _updateCategoryStatus(categoryName, active: false);
  }

  static Future<void> activateCategory(String categoryName) async {
    await _updateCategoryStatus(categoryName, active: true);
  }

  static Future<void> deleteCategory(String categoryName) async {
    // First, get all products in this category
    final productsQuery = await _db
        .collection('products')
        .where('category.name', isEqualTo: categoryName)
        .get();

    // Delete all products in this category
    final batch = _db.batch();
    for (final doc in productsQuery.docs) {
      batch.delete(doc.reference);
    }

    // Delete the category record if it exists
    final categoryQuery = await _db
        .collection('categories')
        .where('name', isEqualTo: categoryName)
        .get();

    for (final doc in categoryQuery.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  static Future<void> _updateCategoryVisibility(String categoryName,
      {required bool hidden}) async {
    // print('Updating category visibility: $categoryName, hidden: $hidden');

    // Update all products in this category
    final productsQuery = await _db
        .collection('products')
        .where('category.name', isEqualTo: categoryName)
        .get();

    // print('Found ${productsQuery.docs.length} products to update');

    final batch = _db.batch();
    for (final doc in productsQuery.docs) {
      batch.update(doc.reference, {
        'category.hidden': hidden,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    }

    // Update category record if it exists
    final categoryQuery = await _db
        .collection('categories')
        .where('name', isEqualTo: categoryName)
        .get();

    // print('Found ${categoryQuery.docs.length} category records to update');

    for (final doc in categoryQuery.docs) {
      batch.update(doc.reference, {
        'hidden': hidden,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    }

    await batch.commit();
    // print('Category visibility update completed');
  }

  static Future<void> _updateCategoryStatus(String categoryName,
      {required bool active}) async {
    // print('Updating category status: $categoryName, active: $active');

    // Update all products in this category
    final productsQuery = await _db
        .collection('products')
        .where('category.name', isEqualTo: categoryName)
        .get();

    // print('Found ${productsQuery.docs.length} products to update');

    final batch = _db.batch();
    for (final doc in productsQuery.docs) {
      batch.update(doc.reference, {
        'category.active': active,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    }

    // Update category record if it exists
    final categoryQuery = await _db
        .collection('categories')
        .where('name', isEqualTo: categoryName)
        .get();

    // print('Found ${categoryQuery.docs.length} category records to update');

    for (final doc in categoryQuery.docs) {
      batch.update(doc.reference, {
        'active': active,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    }

    await batch.commit();
    // print('Category status update completed');
  }

  // Product CRUD Operations
  static Future<void> addProduct({
    required String title,
    required double price,
    required String description,
    required String categoryName,
    List<String> images = const [],
  }) async {
    // Get the next available ID
    final productsSnapshot = await _db.collection('products').get();
    final maxId = productsSnapshot.docs.isEmpty
        ? 0
        : productsSnapshot.docs
            .map((doc) => (doc.data()['id'] as num?)?.toInt() ?? 0)
            .reduce((a, b) => a > b ? a : b);

    final newId = maxId + 1;
    final now = DateTime.now().toIso8601String();

    // Create a basic category object (you might want to fetch the full category data)
    final categoryData = {
      'id': categoryName.hashCode,
      'name': categoryName,
      'slug': categoryName.toLowerCase().replaceAll(' ', '-'),
      'image': '', // You might want to set a default image
      'creationAt': now,
      'updatedAt': now,
      'hidden': false,
      'active': true,
    };

    final productData = {
      'id': newId,
      'title': title,
      'slug': title.toLowerCase().replaceAll(' ', '-'),
      'price': price,
      'description': description,
      'category': categoryData,
      'images': images,
      'creationAt': now,
      'updatedAt': now,
      'hidden': false,
      'active': true,
    };

    await FirestoreService.addDocument('products', productData);
  }

  static Future<void> updateProduct({
    required int productId,
    String? title,
    double? price,
    String? description,
    String? categoryName,
    List<String>? images,
  }) async {
    final updates = <String, dynamic>{
      'updatedAt': DateTime.now().toIso8601String(),
    };

    if (title != null) {
      updates['title'] = title;
      updates['slug'] = title.toLowerCase().replaceAll(' ', '-');
    }
    if (price != null) updates['price'] = price;
    if (description != null) updates['description'] = description;
    if (images != null) updates['images'] = images;

    if (categoryName != null) {
      final now = DateTime.now().toIso8601String();
      updates['category'] = {
        'id': categoryName.hashCode,
        'name': categoryName,
        'slug': categoryName.toLowerCase().replaceAll(' ', '-'),
        'image': '', // You might want to preserve or update the image
        'creationAt': now,
        'updatedAt': now,
        'hidden': false,
        'active': true,
      };
    }

    await FirestoreService.updateDocument(
      'products',
      productId.toString(),
      updates,
    );
  }

  // Filter products for regular users (hide inactive/hidden items)
  static List<ProductModel> filterProductsForUsers(
      List<ProductModel> products) {
    return products.where((product) {
      // Check if product is active and not hidden
      final isProductActive = product.active ?? true;
      final isProductHidden = product.hidden ?? false;

      // Check if category is active and not hidden
      final isCategoryActive = product.category.active ?? true;
      final isCategoryHidden = product.category.hidden ?? false;

      return isProductActive &&
          !isProductHidden &&
          isCategoryActive &&
          !isCategoryHidden;
    }).toList();
  }

  // Get all products for admin (including hidden/inactive)
  static List<ProductModel> getAllProductsForAdmin(
      List<ProductModel> products) {
    return products; // Admin sees everything
  }
}
