import 'dart:convert';
import 'dart:ffi';

import 'package:faker/faker.dart';
import 'package:mesa_news/application/storage/local_storage.dart';
import 'package:mesa_news/domain/entities/account_entity.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/domain/errors/domain_error.dart';
import 'package:mesa_news/domain/usecases/save_favorite.dart';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalStorageSpy extends Mock implements LocalStorage {}

class LocalSaveFavorite implements SaveFavorite {
  final LocalStorage localStorage;

  LocalSaveFavorite({@required this.localStorage});

  @override
  Future<Void> save(NewsEntity newsEntity) {
    throw UnimplementedError();
  }
}

void main() {
  LocalStorageSpy localStorage;
  LocalSaveFavorite sut;
  NewsEntity newsEntity;
  List<NewsEntity> favorites;

  setUp(() {
    localStorage = LocalStorageSpy();
    sut = LocalSaveFavorite(localStorage: localStorage);

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

    favorites = List<NewsEntity>();

    favorites.add(newsEntity);
  });

  test('Should call the save method of LocalStorage with correct values',
      () async {
    await sut.save(newsEntity);

    verify(localStorage.save(key: 'favorites', value: jsonEncode(favorites)));
  });

  test('Should throw UnexpectedError if LocalStorage throws', () {
    when(localStorage.save(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.save(newsEntity);

    expect(future, throwsA(DomainError.unexpected));
  });
}
