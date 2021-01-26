import 'news_entity.dart';

abstract class LoadNews {
  Future<List<NewsEntity>> load();
}
