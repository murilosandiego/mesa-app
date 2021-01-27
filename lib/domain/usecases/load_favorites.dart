import '../entities/news_entity.dart';

abstract class LoadFavorites {
  Future<List<NewsEntity>> load();
}
