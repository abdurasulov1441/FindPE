import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:find_pe/common/db/cache.dart';
import 'package:find_pe/common/utils/errors.dart';
import 'package:logger/logger.dart';
import 'package:find_pe/app/router.dart';


final class RequestHelper {
  final logger = Logger();
  // final baseUrl = 'http://10.100.26.3:4000';
   final baseUrl = 'http://95.130.227.93:8090';
  final dio = Dio();

  void logMethod(String message) {
    log(message);
  }

  String get token {
    final token = cache.getString("user_token");
    if (token == null) {}
    if (token != null) return token;
    // router.go(Routes.loginPage);
    throw UnauthenticatedError();
  }

  Future<dynamic> get(
    String path, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      baseUrl + path,
      cancelToken: cancelToken,
    );

    if (log) {
      logger.d([
        'GET',
        path,
        response.statusCode,
        response.statusMessage,
        response.data,
      ]);

      logMethod(jsonEncode(response.data));
    }

    return response.data;
  }

  Future<dynamic> getWithAuth(
    String path, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    String? token = cache.getString('user_token');

    Future<Response> performRequest(String token) {
      return dio.get(
        baseUrl + path,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
    }

    try {
      final response = await performRequest(token!);

      if (log) {
        logger.d([
          'GET',
          path,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);
      }

      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        final refreshToken = cache.getString('refresh_token');

        if (refreshToken != null) {
          print("Обновление токенов: отправляем refreshToken: $refreshToken");

          try {
            final refreshResponse = await dio.post(
              '$baseUrl/services/zyber/api/auth/refresh',
              data: {'refreshToken': refreshToken},
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            );

            print("Ответ сервера на refresh: ${refreshResponse.data}");

            final newAccessToken = refreshResponse.data['accessToken'];

            if (newAccessToken != null) {
              cache.setString('user_token', newAccessToken);

              // Повторяем исходный запрос с новым токеном
              final retryResponse = await performRequest(newAccessToken);

              if (log) {
                logger.d([
                  'GET (retry)',
                  path,
                  retryResponse.statusCode,
                  retryResponse.statusMessage,
                  retryResponse.data,
                ]);
              }

              return retryResponse.data;
            } else {
              print("Ошибка: Новый accessToken отсутствует.");
              router.go(Routes.homePage); // Переход на экран логина
              throw UnauthenticatedError();
            }
          } catch (refreshError) {
            print("Ошибка при обновлении токенов: $refreshError");

            if (refreshError is DioException && refreshError.response != null) {
              print("Ответ сервера: ${refreshError.response?.data}");
            }

            router.go(Routes.homePage); // Переход на экран логина
            throw UnauthenticatedError();
          }
        } else {
          print("Refresh Token отсутствует в кеше.");
          router.go(Routes.homePage); // Переход на экран логина
          throw UnauthenticatedError();
        }
      } else {
        print("Ошибка запроса: $e");
        rethrow;
      }
    }
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> body, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.post(
        baseUrl + path,
        cancelToken: cancelToken,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (log) {
        logger.d([
          'POST',
          path,
          body,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e) {
      logger.d([
        'POST',
        path,
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
      ]);

      if (e.response?.statusCode == 400) {
        throw e.response?.data['response']['message'];
      }

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        router.go(Routes.homePage);
        if (path == "/services/platon-core/api/mobile/v1/auth/legal/register") {
          router.go(Routes.homePage);
          throw Unauthenticated();
        }
        throw UnauthenticatedError();
      }

      throw e.response?.data['message'];
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> postWithAuth(
    String path,
    Map<String, dynamic> body, {
    bool log = false,
    CancelToken? cancelToken,
    String? languageCode,
  }) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await dio.post(
        baseUrl + path,
        cancelToken: cancelToken,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (log) {
        logger.d([
          'POST',
          path,
          headers,
          body,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);

        logMethod(jsonEncode(response.data));
      }

      return response.data;
    } on DioException catch (e) {
      logger.d([
        'POST',
        path,
        headers,
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
        languageCode
      ]);

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        router.go(Routes.homePage);
        throw UnauthenticatedError();
      }

      switch (languageCode) {
        case 'ru':
          throw e.response?.data['translates']['ru'];
        case 'uz':
          throw e.response?.data['translates']['uz'];
        case 'uk':
          throw e.response?.data['translates']['oz'];
        default:
          throw e.response?.data['message'];
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String path,
    Map<String, dynamic> body, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.put(
        baseUrl + path,
        cancelToken: cancelToken,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (log) {
        logger.d([
          'PUT',
          path,
          body,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);
      }

      return response.data;
    } on DioException catch (e) {
      logger.d([
        'POST',
        path,
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
      ]);
      return e.response?.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> putWithAuth(
    String path,
    Map<String, dynamic> body, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'lang': 'uz',

    };

    try {
      final response = await dio.put(
        baseUrl + path,
        cancelToken: cancelToken,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (log) {
        logger.d([
          'PUT',
          path,
          headers,
          body,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);
      }

      return response.data;
    } on DioException catch (e) {
      logger.d([
        'PUT',
        path,
        headers,
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
      ]);

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        router.go(Routes.homePage);
        throw UnauthenticatedError();
      }

      throw e.response?.data['message'];
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String path, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete(
        baseUrl + path,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (log) {
        logger.d([
          'DELETE',
          path,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);
      }

      return response.data;
    } on DioException catch (e) {
      logger.d([
        'DELETE',
        path,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
      ]);
      return e.response?.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> deleteWithAuth(
    String path, {
    bool log = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete(
        baseUrl + path,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (log) {
        logger.d([
          'DELETE',
          path,
          response.statusCode,
          response.statusMessage,
          response.data,
        ]);
      }

      return response.data;
    } on DioException catch (e) {
      logger.d([
        'DELETE',
        path,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
      ]);

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        router.go(Routes.homePage);
        throw UnauthenticatedError();
      }

      return e.response?.data;
    } catch (_) {
      rethrow;
    }
  }
}

final requestHelper = RequestHelper();
