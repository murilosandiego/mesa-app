import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mesa_news/domain/usecases/load_favorites.dart';
import 'package:mesa_news/domain/usecases/load_news.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';
import 'package:mesa_news/domain/usecases/save_favorite.dart';
import 'package:mesa_news/ui/helpers/app_snackbar.dart';
import 'package:mesa_news/ui/helpers/filter_params.dart';
import 'package:mesa_news/ui/helpers/ui_error.dart';
import 'package:mesa_news/ui/pages/feed/news_viewmodel.dart';
import 'package:meta/meta.dart';

class FeedPresenter extends GetxController {
  final LoadNews loadNews;
  final LoadFavorites loadFavorites;
  final SaveFavorite saveFavorite;

  FeedPresenter({
    @required this.loadNews,
    @required this.loadFavorites,
    @required this.saveFavorite,
  });

  final _isLoading = true.obs;
  final _mainError = ''.obs;
  List<NewsEntity> _listAllNewsEntity;
  List<NewsEntity> _listFavorites;

  bool get isLoading => _isLoading.value;

  final news = RxList<NewsViewModel>();

  String get mainError => _mainError.value;

  load({FilterParams filterParams}) async {
    _isLoading.value = true;
    try {
      _listAllNewsEntity = await loadNews.load(
        publishedAt: filterParams?.filterDate?.date,
      );

      _listFavorites = await loadFavorites.load();

      if (filterParams?.isFavorite == true) {
        news.assignAll(_listFavorites.map((news) {
          return toViewModel(news: news, isFavorite: true);
        }));
      } else {
        news.assignAll(_listAllNewsEntity.map((news) {
          final isFavorite = _listFavorites.contains(news);

          return toViewModel(news: news, isFavorite: isFavorite);
        }));
      }
    } catch (_) {
      _mainError.value = UIError.unexpected.description;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> addFavorite(NewsViewModel newsViewModel) async {
    try {
      final newsEntity = _listAllNewsEntity
          .firstWhere((news) => news.title == newsViewModel.title);

      await saveFavorite.save(newsEntity);

      newsViewModel.isFavorite = !newsViewModel.isFavorite;
    } catch (_) {
      AppSnackbar.showError(message: 'Não possível adicionar aos favoritos');
    }
  }

  NewsViewModel toViewModel(
      {@required NewsEntity news, DateTime now, bool isFavorite}) {
    final _now = now ?? DateTime.now();

    final difference = _now.difference(news.publishedAt).inHours;

    final publishedAt = difference <= 24
        ? '$difference horas atrás'
        : DateFormat('dd/MM/yyyy hh:mm').format(news.publishedAt);

    final newsViewModel = NewsViewModel(
        description: news.description,
        imageUrl: news.imageUrl,
        publishedAt: publishedAt,
        title: news.title,
        url: news.url,
        highlight: news.highlight);

    if (isFavorite) {
      newsViewModel.isFavorite = true;
    }

    return newsViewModel;
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }
}
