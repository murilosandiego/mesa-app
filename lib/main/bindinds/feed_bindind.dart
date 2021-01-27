import 'package:get/get.dart';

import '../../application/usecases/local_load_favorites.dart';
import '../../application/usecases/local_save_favorites.dart';
import '../../application/usecases/remote_load_news.dart';
import '../../domain/usecases/load_favorites.dart';
import '../../domain/usecases/load_news.dart';
import '../../domain/usecases/save_favorite.dart';
import '../../ui/pages/feed/feed_presenter.dart';
import '../decorators/authorize_http_client_decorator.dart';
import '../factories/api_url_factory.dart';

class FeedBinding implements Bindings {
  @override
  void dependencies() {
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
  }
}
