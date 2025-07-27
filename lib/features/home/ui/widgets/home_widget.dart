import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/admin_service.dart';
import '../../../../core/widgets/custom_pull_to_refresh.dart';
import '../../data/models/product_model.dart';
import '../../logic/products/products_cubit.dart';
import '../../logic/products/products_state.dart';
import 'home_widget_skeletonizer.dart';
import 'home_widget_success.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late final ProductsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProductsCubit>();
    _cubit.listenToFirestoreProducts();
  }

  void reloadProducts() {
    _cubit.refreshProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>.value(
      value: _cubit,
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return PullToRefresh(
            onRefresh: () async => reloadProducts(),
            child: state.maybeWhen(
              loading: () => HomeWidgetSkeletonizer(),
              success: (data) {
                final List<ProductModel> products = data;
                // Always filter products for home screen to show user experience
                // even for admin users
                final filteredProducts =
                    AdminService.filterProductsForUsers(products);
                return HomeWidgetSuccess(products: filteredProducts);
              },
              error: (error) => Center(child: Text(error)),
              orElse: () => SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
