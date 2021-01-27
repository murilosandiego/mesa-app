import '../entities/news_entity.dart';

abstract class SaveFavorite {
  Future<void> save(NewsEntity newsEntity);
}
