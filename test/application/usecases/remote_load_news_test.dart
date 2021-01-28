import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mesa_news/application/http/http_client.dart';
import 'package:mesa_news/application/http/http_error.dart';
import 'package:mesa_news/application/usecases/remote_load_news.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/domain/errors/domain_error.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  RemoteLoadNews sut;
  HttpClientMock httpClient;
  String url;

  mockSuccess() => when(httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
          body: anyNamed('body')))
      .thenAnswer((_) async => jsonDecode(apiNewsReponse));

  mockError() => when(httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
          body: anyNamed('body')))
      .thenThrow(HttpError.badRequest);

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();

    sut = RemoteLoadNews(
      httpClient: httpClient,
      url: url,
    );

    mockSuccess();
  });

  test('should call HttpClient with correct values', () async {
    await sut.load();

    verify(
      httpClient.request(
        url: '$url?current_page=&per_page=&published_at=',
        method: 'get',
      ),
    );
  });

  test('should throw UnexpectedError if not HttpClient returns 200', () {
    mockError();
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should return an NewsEntity if HttpClient returns 200', () async {
    final news = await sut.load();

    expect(news, isA<List<NewsEntity>>());
    expect(news, factoryListNews);
  });
}
