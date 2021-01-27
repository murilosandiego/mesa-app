import 'dart:convert';

import 'package:mesa_news/application/storage/local_storage.dart';
import 'package:mesa_news/application/usecases/local_load_favorites.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/domain/errors/domain_error.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  LocalStorageSpy localStorage;
  LocalLoadFavorites sut;

  mockSuccess() => when(localStorage.fetch(key: anyNamed('key')))
      .thenAnswer((_) async => jsonEncode(factoryListFavoritesToJson));

  setUp(() {
    localStorage = LocalStorageSpy();
    sut = LocalLoadFavorites(localStorage: localStorage);

    mockSuccess();
  });

  test('Should call LocalStorage with currect value', () async {
    await sut.load();

    verify(localStorage.fetch(key: 'favorites'));
  });

  test('Shoud return a List of the NewsEntity', () async {
    final favorites = await sut.load();

    expect(favorites, isA<List<NewsEntity>>());
    expect(favorites, factoryListFavorites);
  });

  test('Shoud throw DomainError.unexpected if LocalStorage throws', () {
    when(localStorage.fetch(key: anyNamed('key')))
        .thenThrow(DomainError.unexpected);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
