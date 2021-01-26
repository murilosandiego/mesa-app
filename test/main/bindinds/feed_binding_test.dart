import 'package:get/instance_manager.dart';
import 'package:mesa_news/application/usecases/remote_load_news.dart';
import 'package:mesa_news/domain/entities/load_news.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:test/test.dart';

void main() {
  final binding = BindingsBuilder(() {
    Get.lazyPut<LoadNews>(
      () => RemoteLoadNews(
        httpClient: Get.find(),
        url: 'v1/client/auth/news',
      ),
    );
    Get.lazyPut<FeedPresenter>(() => FeedPresenter(loadNews: Get.find()));
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
