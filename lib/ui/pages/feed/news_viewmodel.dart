import 'package:equatable/equatable.dart';
import 'package:get/state_manager.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';

class NewsViewModel extends Equatable {
  NewsViewModel({
    this.title,
    this.description,
    this.content,
    this.author,
    this.publishedAt,
    this.highlight,
    this.url,
    this.imageUrl,
  });

  final String title;
  final String description;
  final String content;
  final String author;
  final DateTime publishedAt;
  final _publishedAtFormated = ''.obs;
  final bool highlight;
  final String url;
  final String imageUrl;
  final _isFavorite = false.obs;

  bool get isFavorite => _isFavorite.value;
  set isFavorite(bool value) => _isFavorite.value = value;

  String get publishedAtFormated => _publishedAtFormated.value;
  set publishedAtFormated(String value) => _publishedAtFormated.value = value;

  factory NewsViewModel.fromEntity(NewsEntity newsEntity) => NewsViewModel(
        author: newsEntity.author,
        content: newsEntity.content,
        description: newsEntity.description,
        highlight: newsEntity.highlight,
        imageUrl: newsEntity.imageUrl,
        publishedAt: newsEntity.publishedAt,
        title: newsEntity.title,
        url: newsEntity.url,
      );

  NewsEntity toEntity(NewsViewModel newsViewModel) => NewsEntity(
        author: newsViewModel.author,
        content: newsViewModel.content,
        description: newsViewModel.description,
        highlight: newsViewModel.highlight,
        imageUrl: newsViewModel.imageUrl,
        publishedAt: newsViewModel.publishedAt,
        title: newsViewModel.title,
        url: newsViewModel.url,
      );

  @override
  List get props => [
        title,
        description,
        content,
        author,
        publishedAt,
        highlight,
        url,
        imageUrl,
        isFavorite
      ];
}
