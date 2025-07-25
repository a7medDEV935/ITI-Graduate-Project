import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/auth/data/repo/firebase_auth_repo.dart';
import '../../features/auth/logic/auth/auth_cubit.dart';
import '../../features/home/data/repo/product_repo.dart';
import '../../features/home/logic/notifications/notification_cubit.dart';
import '../../features/home/logic/products/products_cubit.dart';
import '../networking/api_constants.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';
import '../theme/cubit/theme/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio , baseUrl: ApiConstants.apiBaseUrl));

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(authRepo: getIt<FirebaseRepo>()));

  getIt.registerLazySingleton<FirebaseRepo>(() => FirebaseRepo());

  getIt.registerLazySingleton<ProductRepo>(() => ProductRepo());
  getIt.registerLazySingleton<ProductsCubit>(() => ProductsCubit(getIt<ProductRepo>()));

  getIt.registerLazySingleton<NotificationCubit>(() => NotificationCubit());


}
