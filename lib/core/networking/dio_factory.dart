import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static Dio getDio() {
    if (dio == null) {
      dio = Dio();

      dio!
        ..options.baseUrl = ApiConstants.baseUrl
        ..options.connectTimeout = const Duration(seconds: 60)
        ..options.receiveTimeout = const Duration(seconds: 60);

      addDioInterceptor();
    }

    return dio!;
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
        //  final token = await AuthSessionManager.getActiveToken();
        /*  if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }*/
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
         
         /*   if (error.requestOptions.path != 'UserV2/login') {
              await AuthSessionManager.logout();
              AppNavigationService.navigateAndClearStack(AppRoutes.login);
            }*/
          }
          return handler.next(error);
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}