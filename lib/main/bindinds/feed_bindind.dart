import 'package:get/get.dart';
import 'package:mesa_news/application/usecases/remote_load_news.dart';
import 'package:mesa_news/domain/usecases/load_news.dart';
import 'package:mesa_news/main/decorators/authorize_http_client_decorator.dart';
import 'package:mesa_news/main/factories/api_url_factory.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';

class FeedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadNews>(() => RemoteLoadNews(
          httpClient: AuthorizeHttpClientDecorator(
            decoratee: Get.find(),
            localStorage: Get.find(),
          ),
          url: makeApiUrl(
            ('v1/client/news'),
          ),
        ));
    Get.lazyPut<FeedPresenter>(() => FeedPresenter(loadNews: Get.find()));
  }
}
