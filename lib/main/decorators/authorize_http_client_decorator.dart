import 'package:mesa_news/application/http/http_client.dart';
import 'package:mesa_news/application/http/http_error.dart';
import 'package:mesa_news/application/storage/local_storage.dart';
import 'package:meta/meta.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final LocalStorage localStorage;
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator({
    @required this.localStorage,
    @required this.decoratee,
  });

  Future<dynamic> request({
    @required String url,
    @required String method,
    Map body,
    Map headers,
  }) async {
    try {
      final token = await localStorage.fetch(key: 'token');
      final authorizedHeaders = headers ?? {}
        ..addAll({'Authorization': 'Bearer $token'});
      return await decoratee.request(
          url: url, method: method, body: body, headers: authorizedHeaders);
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        // await deleteSecureCacheStorage.delete('token');
        throw HttpError.forbidden;
      }
    }
  }
}
