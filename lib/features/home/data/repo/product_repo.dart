import '../../../../core/di/dependency_injection.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/product_model.dart';

class ProductRepo{

  final apiService = getIt<ApiService>();

  Future<ApiResult<List<ProductModel>>> fetchProducts() async {
    try {
      final response = await apiService.fetchProducts();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

}
