import '../../domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  NewsModel({
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

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        content: json["content"] == null ? null : json["content"],
        author: json["author"] == null ? null : json["author"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        highlight: json["highlight"] == null ? null : json["highlight"],
        url: json["url"] == null ? null : json["url"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
      );
}
