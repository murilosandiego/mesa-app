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
  final _lastPage = false.obs;
  final _isFavorite = false.obs;

  final news = RxList<NewsViewModel>();

  List<NewsEntity> _listNews;
  List<NewsEntity> _listFavorites;

  int currentPage = 1;
  FilterParams _filterParams;

  bool get isLoading => _isLoading.value;
  String get mainError => _mainError.value;
  bool get lastPage => _lastPage.value;
  bool get isFavorite => _isFavorite.value;

  Future<void> load({FilterParams filterParams}) async {
    try {
      _filterParams = filterParams;
      _isLoading.value = true;

      await _loadFavorites();
      if (filterParams?.isFavorite == true) {
        _isFavorite.value = true;
        _assingFavoriteList();
      } else {
        await _loadNews();
        _assingNewsList();
      }
    } catch (_) {
      _mainError.value = UIError.unexpected.description;
    } finally {
      _isLoading.value = false;
      _lastPage.value = false;
    }
  }

  Future<void> loadMoreNews() async {
    try {
      currentPage++;
      if (_filterParams == null) {
        _filterParams = FilterParams();
      }

      _filterParams.currentPage = currentPage;

      await _loadNews();
      _addAllNewsList();
    } catch (_) {
      _mainError.value = UIError.unexpected.description;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> addFavorite(NewsViewModel newsViewModel) async {
    try {
      await saveFavorite.save(newsViewModel.toEntity(newsViewModel));

      newsViewModel.isFavorite = !newsViewModel.isFavorite;
    } catch (_) {
      AppSnackbar.showError(message: 'Não possível adicionar aos favoritos');
    }
  }

  Future<void> _loadNews() async {
    _isFavorite.value = false;
    final newsEntity = await loadNews.load(
      publishedAt: _filterParams?.filterDate?.dateString,
      currentPage: _filterParams?.currentPage.toString(),
    );

    if (newsEntity.isEmpty) {
      _lastPage.value = true;
    }

    _listNews = newsEntity;
  }

  void _assingNewsList() {
    news.assignAll(_listNews.map((news) {
      final isFavorite =
          _listFavorites == null ? false : _listFavorites.contains(news);

      return _toViewModel(news: news, isFavorite: isFavorite);
    }));
  }

  void _addAllNewsList() {
    news.addAll(_listNews.map((news) {
      final isFavorite =
          _listFavorites == null ? false : _listFavorites.contains(news);

      return _toViewModel(news: news, isFavorite: isFavorite);
    }));
  }

  Future<void> _loadFavorites() async {
    final result = await loadFavorites.load();
    if (_filterParams?.filterDate?.date == null) {
      _listFavorites = result;
      return;
    }

    final favoriteFilter = result
        .where(
            (element) => element.publishedAt == _filterParams.filterDate.date)
        .toList();

    _listFavorites = favoriteFilter;
  }

  void _assingFavoriteList() {
    news.assignAll(_listFavorites
        .map((news) => _toViewModel(news: news, isFavorite: true)));
  }

  NewsViewModel _toViewModel(
      {@required NewsEntity news, DateTime now, bool isFavorite}) {
    final newsViewModel = NewsViewModel.fromEntity(news);

    final _now = now ?? DateTime.now();
    final difference = _now.difference(news.publishedAt).inHours;
    final publishedAtFormated = difference <= 24
        ? '$difference horas atrás'
        : DateFormat('dd/MM/yyyy hh:mm').format(news.publishedAt);

    newsViewModel.publishedAtFormated = publishedAtFormated;

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
