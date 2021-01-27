import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mesa_news/application/models/news_model.dart';
import 'package:mesa_news/application/storage/local_storage.dart';
import 'package:mesa_news/application/usecases/local_save_favorites.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/domain/errors/domain_error.dart';
import 'package:mesa_news/domain/usecases/load_favorites.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

class LocalStorageSpy extends Mock implements LocalStorage {}

class LoadFavoritesSpy extends Mock implements LoadFavorites {}

void main() {
  LocalSaveFavorite sut;
  LocalStorageSpy localStorage;
  LoadFavorites loadFavorites;
  NewsEntity newsEntity;
  List mockFavorites;

  mockSuccess() =>
      when(loadFavorites.load()).thenAnswer((_) async => factoryListFavorites);

  setUp(() {
    loadFavorites = LoadFavoritesSpy();
    localStorage = LocalStorageSpy();
    sut = LocalSaveFavorite(
      localStorage: localStorage,
      loadFavorites: loadFavorites,
    );

    newsEntity = NewsEntity(
      author: faker.person.name(),
      content: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      highlight: false,
      imageUrl: faker.internet.httpsUrl(),
      publishedAt: faker.date.dateTime(),
      title: faker.lorem.sentence(),
      url: faker.internet.httpsUrl(),
    );

    final newsModelJson = NewsModel.fromEntity(newsEntity).toJson();

    mockFavorites = factoryListFavoritesToJson..add(newsModelJson);
    mockSuccess();
  });

  test(
      'Should call the loadFavorites method of LoadFavorites use case with correct values',
      () async {
    await sut.save(newsEntity);

    verify(loadFavorites.load());
  });

  test('Should call the save method of LocalStorage with correct values',
      () async {
    await sut.save(newsEntity);

    verify(
        localStorage.save(key: 'favorites', value: jsonEncode(mockFavorites)));
  });

  test('Should throw UnexpectedError if LocalStorage throws', () {
    when(localStorage.save(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.save(newsEntity);

    expect(future, throwsA(DomainError.unexpected));
  });
}
