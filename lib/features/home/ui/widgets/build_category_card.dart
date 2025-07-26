import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../data/models/product_model.dart';
import '../../logic/cart/cart_cubit.dart';
import '../category_products_screen.dart';

Widget buildCategoryCard(
  BuildContext context, {
  required Map<String, dynamic> category,
  required List<ProductModel> products,
}) {
  final theme = Theme.of(context);
  return Container(
    width: 90,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: getIt<CartCubit>(),
              child: CategoryProductsScreen(
                category: category['name'],
                products: products,
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: (category['color'] as Color).withAlpha(10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: (category['color'] as Color).withAlpha(30),
                width: 1,
              ),
            ),
            child: Icon(
              category['icon'] as IconData,
              size: 32,
              color: category['color'] as Color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category['name'],
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${products.length} items',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withAlpha(60),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
