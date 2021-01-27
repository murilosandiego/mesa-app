import 'package:equatable/equatable.dart';
import 'package:get/state_manager.dart';

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
  final String publishedAt;
  final bool highlight;
  final String url;
  final String imageUrl;
  final _isFavorite = false.obs;

  bool get isFavorite => _isFavorite.value;

  set isFavorite(bool value) => _isFavorite.value = value;

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
