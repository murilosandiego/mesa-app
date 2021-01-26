import 'package:get/get.dart';
import 'package:mesa_news/application/usecases/remote_load_news.dart';
import 'package:mesa_news/domain/entities/load_news.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';

class FeedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadNews>(
      () => RemoteLoadNews(
        httpClient: Get.find(),
        url: 'v1/client/auth/news',
      ),
    );
    Get.lazyPut<FeedPresenter>(() => FeedPresenter(loadNews: Get.find()));
  }
}
