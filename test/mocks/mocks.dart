import 'package:faker/faker.dart';
import 'package:mesa_news/application/models/news_model.dart';
import 'package:mesa_news/domain/entities/news_entity.dart';

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

const apiNewsReponseWithPagination = """
{
  "pagination": {
    "current_page": 1,
    "per_page": 50,
    "total_pages": 4,
    "total_items": 167
  },
  "data": [
    {
      "title": "Cramer: 'I'm more nervous than I was before' about coronavirus economic risks after Fed rate cut - CNBC",
      "description": "\"It's great that the Federal Reserve recognizes that there's going to be weakness, but it makes me feel, wow, the weakness must be much more than I thought,\" CNBC's Jim Cramer said.",
      "content": "CNBC's Jim Cramer said the Federal Reserve's emergency interest rate cut on Tuesday morning makes him more concerned about the economic risks from the coronavirus.\r\n\"It's great that the Federal Reserve recognizes that there's going to be weakness, but it make… [+3208 chars]",
      "author": "Kevin Stankiewicz",
      "published_at": "2020-07-09T17:15:05.000Z",
      "highlight": true,
      "url": "https://www.cnbc.com/2020/03/03/cramer-is-more-nervous-about-coronavirus-risks-after-fed-rate-cut.html",
      "image_url": "https://image.cnbcfm.com/api/v1/image/104326296-20150310-8625-1120.JPG?v=1488902930"
    },
    {
      "title": "A Tom Brady, Antonio Brown package deal seems incredibly unlikely - NBCSports.com",
      "description": "Since the media is now required to file at least 17 Tom Brady stories per day (and since we’re part of that media), here’s another one. Albeit very far-fetched. An item posted at ESPN.com suggests that Brady and receiver Antonio Brown could be some sort of a …",
      "content": "Since the media is now required to file at least 17 Tom Brady stories per day (and since we’re part of that media), here’s another one. Albeit very far-fetched.\r\nAn item posted at ESPN.com suggests that Brady and receiver Antonio Brown could be some sort of a… [+1330 chars]",
      "author": "Mike Florio",
      "published_at": "2020-07-09T17:15:05.000Z",
      "highlight": true,
      "url": "https://profootballtalk.nbcsports.com/2020/03/03/a-tom-brady-antonio-brown-package-deal-seems-incredibly-unlikely/",
      "image_url": "https://profootballtalk.nbcsports.com/wp-content/uploads/sites/25/2020/03/GettyImages-1169598610-e1583249139618.jpg"
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
  title: 'title',
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

List<NewsEntity> factoryListFavorites = [
  news1,
  news2,
];

final newsEntity = NewsEntity(
  author: faker.person.name(),
  content: faker.lorem.sentence(),
  description: faker.lorem.sentence(),
  highlight: false,
  imageUrl: faker.internet.httpsUrl(),
  publishedAt: faker.date.dateTime(),
  title: faker.lorem.sentence(),
  url: faker.internet.httpsUrl(),
);

final newsModelJson = NewsModel.fromEntity(newsEntity).toJson();

List factoryNewsModel = factoryListFavoritesToJson..add(newsModelJson);
