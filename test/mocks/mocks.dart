import 'package:faker/faker.dart';
import 'package:mesa_news/application/models/news_model.dart';

const apiNewsReponse = """
{
  "pagination": {
    "current_page": 1,
    "per_page": 20,
    "total_pages": 1,
    "total_items": 2
  },
  "data": [
    {
      "title": "News 1 title",
      "description": "News 1 description",
      "content": "News 1 content",
      "author": "News 1 author",
      "published_at": "2020-01-30T13:45:00.000Z",
      "highlight": false,
      "url": "https://fake.news",
      "image_url": "https://via.placeholder.com/600x300"
    },
    {
      "title": "News 2 title",
      "description": "News 2 description",
      "content": "News 2 content",
      "author": "News 2 author",
      "published_at": "2020-01-29T17:22:13.000Z",
      "highlight": true,
      "url": "https://fake.news",
      "image_url": "https://via.placeholder.com/600x300"
    }
  ]
}
""";

final factoryListNews = [
  NewsModel(
      title: "News 1 title",
      description: "News 1 description",
      content: "News 1 content",
      author: "News 1 author",
      publishedAt: DateTime.parse("2020-01-30T13:45:00.000Z"),
      highlight: false,
      url: "https://fake.news",
      imageUrl: "https://via.placeholder.com/600x300"),
  NewsModel(
      title: "News 2 title",
      description: "News 2 description",
      content: "News 2 content",
      author: "News 2 author",
      publishedAt: DateTime.parse("2020-01-29T17:22:13.000Z"),
      highlight: true,
      url: "https://fake.news",
      imageUrl: "https://via.placeholder.com/600x300")
];

final news1 = NewsModel(
  author: faker.person.name(),
  content: faker.lorem.sentence(),
  description: faker.lorem.sentence(),
  highlight: false,
  imageUrl: faker.internet.httpsUrl(),
  publishedAt: faker.date.dateTime(),
  title: faker.lorem.sentence(),
  url: faker.internet.httpsUrl(),
);

final news2 = NewsModel(
  author: faker.person.name(),
  content: faker.lorem.sentence(),
  description: faker.lorem.sentence(),
  highlight: false,
  imageUrl: faker.internet.httpsUrl(),
  publishedAt: faker.date.dateTime(),
  title: faker.lorem.sentence(),
  url: faker.internet.httpsUrl(),
);

List factoryListFavoritesToJson = [
  news1.toJson(),
  news2.toJson(),
];

List factoryListFavorites = [
  news1,
  news2,
];
