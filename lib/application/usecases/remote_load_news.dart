import 'package:meta/meta.dart';

import '../../domain/usecases/load_news.dart';
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
  Future<List<NewsEntity>> load({
    String currentPage,
    String perPage,
    String publishedAt,
  }) async {
    String _currentPage = currentPage ?? '';
    String _perPage = perPage ?? '';
    String _publishedAt = publishedAt ?? '';

    String _url =
        '$url?current_page=$_currentPage&per_page=$_perPage&published_at=$_publishedAt';
    try {
      final httpResponse = await httpClient.request(url: _url, method: 'get');
      final news = (httpResponse['data'] as List)
          .map((json) => NewsModel.fromJson(json))
          .toList()
            ..sort((a, b) => b.publishedAt.compareTo(b.publishedAt));

      return news;
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
