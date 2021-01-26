import 'news_entity.dart';

abstract class LoadNews {
  Future<NewsEntity> load();
}
