import '../entities/news_entity.dart';

abstract class LoadNews {
  Future<List<NewsEntity>> load({
    String currentPage,
    String perPage,
    String publishedAt,
  });
}
