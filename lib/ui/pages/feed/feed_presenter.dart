import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mesa_news/domain/entities/load_news.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/ui/helpers/ui_error.dart';
import 'package:mesa_news/ui/pages/feed/news_viewmodel.dart';
import 'package:meta/meta.dart';

class FeedPresenter extends GetxController {
  final LoadNews loadNews;

  FeedPresenter({@required this.loadNews});

  final _isLoading = true.obs;
  final _mainError = ''.obs;

  bool get isLoading => _isLoading.value;

  final news = RxList<NewsViewModel>();

  String get mainError => _mainError.value;

  load() async {
    try {
      final result = await loadNews.load();
      news.assignAll(result.map((news) => toViewModel(news: news)));
    } catch (_) {
      _mainError.value = UIError.unexpected.description;
    } finally {
      _isLoading.value = false;
    }
  }

  toViewModel({@required NewsEntity news, DateTime now}) {
    final _now = now ?? DateTime.now();

    final difference = _now.difference(news.publishedAt).inHours;

    final publishedAt = difference <= 24
        ? '$difference horas atrás'
        : DateFormat('dd/MM/yyyy hh:mm').format(news.publishedAt);

    return NewsViewModel(
      description: news.description,
      imageUrl: news.imageUrl,
      publishedAt: publishedAt,
      title: news.title,
      url: news.url,
    );
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }
}
