import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


import '../../features/home/data/models/product_model.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl , ParseErrorLogger? errorLogger}) = _ApiService;

  @GET("/products")
  Future<List<ProductModel>> fetchProducts();

}
