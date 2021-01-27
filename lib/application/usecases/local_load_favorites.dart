import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/news_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/load_favorites.dart';
import '../models/news_model.dart';
import '../storage/local_storage.dart';

class LocalLoadFavorites implements LoadFavorites {
  final LocalStorage localStorage;

  LocalLoadFavorites({@required this.localStorage});

  @override
  Future<List<NewsEntity>> load() async {
    try {
      final localStorageResult = await localStorage.fetch(key: 'favorites');

      return localStorageResult == null
          ? null
          : (jsonDecode(localStorageResult) as List)
              .map((json) => NewsModel.fromJson(json))
              .toList();
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
