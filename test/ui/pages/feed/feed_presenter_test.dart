import 'package:mesa_news/domain/usecases/load_favorites.dart';
import 'package:mesa_news/domain/usecases/load_news.dart';

import 'package:mesa_news/domain/errors/domain_error.dart';
import 'package:mesa_news/domain/usecases/save_favorite.dart';
import 'package:mesa_news/ui/helpers/ui_error.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:mesa_news/ui/pages/feed/news_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../mocks/mocks.dart';

class LoadNewsSpy extends Mock implements LoadNews {}

class LoadFavoritesSpy extends Mock implements LoadFavorites {}

class SaveFavoritesSpy extends Mock implements SaveFavorite {}

void main() {
  FeedPresenter sut;
  LoadNewsSpy loadNews;
  LoadFavoritesSpy loadFavorites;
  SaveFavoritesSpy saveFavorites;

  mockSuccess() =>
      when(loadNews.load()).thenAnswer((_) async => factoryListNews);

  mockError() => when(loadNews.load()).thenThrow(DomainError.unexpected);

  setUp(() {
    loadNews = LoadNewsSpy();
    sut = FeedPresenter(
      loadNews: loadNews,
      saveFavorite: saveFavorites,
      loadFavorites: loadFavorites,
    );

    mockSuccess();
  });

  group('LoadNews use case', () {
    test('Should calls LoadNews onInit', () async {
      await sut.load();

      verify(loadNews.load()).called(1);
    });

    test('Should show and hide loading', () async {
      expect(sut.isLoading, true);

      await sut.load();

      expect(sut.isLoading, false);
    });

    test('Should set News list in news variable', () async {
      when(loadNews.load()).thenAnswer((_) async => factoryListNews);
      await sut.load();

      expect(sut.news, isA<List<NewsViewModel>>());
    });

    test('Should set UIError.unexpected if error occurs', () async {
      mockError();

      await sut.load();

      expect(sut.mainError, UIError.unexpected.description);
      expect(sut.isLoading, false);
    });
  });
}
