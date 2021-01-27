import 'dart:ffi';

import '../entities/news_entity.dart';

abstract class SaveFavorite {
  Future<Void> save(NewsEntity newsEntity);
}
