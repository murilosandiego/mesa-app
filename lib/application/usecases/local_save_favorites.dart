import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/news_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/load_favorites.dart';
import '../../domain/usecases/save_favorite.dart';
import '../models/news_model.dart';
import '../storage/local_storage.dart';

class LocalSaveFavorite implements SaveFavorite {
  final LocalStorage localStorage;
  final LoadFavorites loadFavorites;

  LocalSaveFavorite({
    @required this.localStorage,
    @required this.loadFavorites,
  });

  @override
  Future<void> save(NewsEntity newsEntity) async {
    try {
      List<NewsEntity> favorites = await _loadFovorites();

      final newsModel = NewsModel.fromEntity(newsEntity);

      if (favorites.contains(newsModel)) {
        favorites.remove(newsModel);
      } else {
        favorites.add(newsModel);
      }

      final newsFavoriteToJson = favorites
        ..map((newsEntity) => NewsModel.fromEntity(newsEntity).toJson());

      await localStorage.save(
          key: 'favorites', value: jsonEncode(newsFavoriteToJson));
    } catch (_) {
      throw DomainError.unexpected;
    }
  }

  Future<List<NewsEntity>> _loadFovorites() async {
    final favorites = await loadFavorites.load();
    if (favorites == null) return List<NewsEntity>();

    return favorites;
  }
}
