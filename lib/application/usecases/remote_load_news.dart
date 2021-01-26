import 'package:meta/meta.dart';

import '../../domain/entities/load_news.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../http/http_client.dart';
import '../models/news_model.dart';

class RemoteLoadNews implements LoadNews {
  final HttpClient httpClient;
  final String url;

  RemoteLoadNews({
    @required this.httpClient,
    @required this.url,
  });

  @override
  Future<List<NewsEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      final news = (httpResponse['data'] as List)
          .map(
            (json) => NewsModel.fromJson(json),
          )
          .toList();

      return news;
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
