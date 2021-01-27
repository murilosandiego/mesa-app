import 'package:equatable/equatable.dart';

class NewsViewModel extends Equatable {
  NewsViewModel({
    this.title,
    this.description,
    this.publishedAt,
    this.url,
    this.imageUrl,
  });

  final String title;
  final String description;
  final DateTime publishedAt;
  final String url;
  final String imageUrl;

  @override
  List get props => [
        title,
        description,
        publishedAt,
        url,
        imageUrl,
      ];
}
