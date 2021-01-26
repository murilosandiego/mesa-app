import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  NewsEntity({
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
  final bool highlight;
  final String url;
  final String imageUrl;

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
      ];
}
