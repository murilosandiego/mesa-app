import 'package:get/instance_manager.dart';
import 'package:mesa_news/application/usecases/local_load_favorites.dart';
import 'package:mesa_news/application/usecases/local_save_favorites.dart';
import 'package:mesa_news/application/usecases/remote_load_news.dart';
import 'package:mesa_news/domain/usecases/load_favorites.dart';
import 'package:mesa_news/domain/usecases/load_news.dart';
import 'package:mesa_news/domain/usecases/save_favorite.dart';
import 'package:mesa_news/main/decorators/authorize_http_client_decorator.dart';
import 'package:mesa_news/main/factories/api_url_factory.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:test/test.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<LoadFavorites>(
        () => LocalLoadFavorites(localStorage: Get.find()));
    Get.lazyPut<SaveFavorite>(() =>
        LocalSaveFavorite(localStorage: Get.find(), loadFavorites: Get.find()));
    Get.lazyPut<LoadNews>(() => RemoteLoadNews(
          httpClient: AuthorizeHttpClientDecorator(
            decoratee: Get.find(),
            localStorage: Get.find(),
          ),
          url: makeApiUrl(
            ('v1/client/news'),
          ),
        ));
    Get.lazyPut<FeedPresenter>(() => FeedPresenter(
          loadNews: Get.find(),
          loadFavorites: Get.find(),
          saveFavorite: Get.find(),
        ));
  });

  test('Test Bindings', () {
    expect(Get.isPrepared<LoadNews>(), false);
    expect(Get.isPrepared<FeedPresenter>(), false);

    binding.builder();

    expect(Get.isPrepared<LoadNews>(), true);
    expect(Get.isPrepared<FeedPresenter>(), true);

    Get.reset();
  });
}
