import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mesa_news/application/models/news_model.dart';
import 'package:mesa_news/application/storage/local_storage.dart';
import 'package:mesa_news/application/usecases/local_load_favorites.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/domain/errors/domain_error.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  LocalStorageSpy localStorage;
  LocalLoadFavorites sut;
  List factoryListfavorites;

  mockSuccess() => when(localStorage.fetch(key: anyNamed('key')))
      .thenAnswer((_) async => jsonEncode(factoryListfavorites));

  setUp(() {
    localStorage = LocalStorageSpy();
    sut = LocalLoadFavorites(localStorage: localStorage);

    factoryListfavorites = [
      NewsModel(
        author: faker.person.name(),
        content: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
        highlight: false,
        imageUrl: faker.internet.httpsUrl(),
        publishedAt: faker.date.dateTime(),
        title: faker.lorem.sentence(),
        url: faker.internet.httpsUrl(),
      ).toJson(),
      NewsModel(
        author: faker.person.name(),
        content: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
        highlight: false,
        imageUrl: faker.internet.httpsUrl(),
        publishedAt: faker.date.dateTime(),
        title: faker.lorem.sentence(),
        url: faker.internet.httpsUrl(),
      ).toJson(),
    ];

    mockSuccess();
  });

  test('Should call LocalStorage with currect value', () async {
    await sut.load();

    verify(localStorage.fetch(key: 'favorites'));
  });

  test('Shoud return a List of the NewsEntity', () async {
    final favorites = await sut.load();

    expect(favorites, isA<List<NewsEntity>>());
    expect(favorites.length, 2);
  });

  test('Shoud throw DomainError.unexpected if LocalStorage throws', () {
    when(localStorage.fetch(key: anyNamed('key')))
        .thenThrow(DomainError.unexpected);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
