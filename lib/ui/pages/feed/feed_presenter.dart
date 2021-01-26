import 'package:get/get.dart';
import 'package:mesa_news/domain/entities/load_news.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/ui/helpers/ui_error.dart';
import 'package:meta/meta.dart';

class FeedPresenter extends GetxController {
  final LoadNews loadNews;

  FeedPresenter({@required this.loadNews});

  final _isLoading = true.obs;
  final _mainError = Rx<UIError>();

  bool get isLoading => _isLoading.value;

  final news = RxList<NewsEntity>();

  get mainError => _mainError.value;

  load() async {
    try {
      final result = await loadNews.load();
      news.assignAll(result);
    } catch (_) {
      _mainError.value = UIError.unexpected;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }
}
