import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:mesa_news/ui/pages/feed/news_viewmodel.dart';

class NewsPage extends StatelessWidget {
  final NewsViewModel newsViewModel;

  const NewsPage({@required this.newsViewModel});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<FeedPresenter>();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Text(
                  newsViewModel.title,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  'mesanews.com.br',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
          ]),
      body: ListView(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        children: [
          Container(
            height: 195,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: newsViewModel.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: newsViewModel.imageUrl,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        'lib/ui/assets/images/image_error.png',
                      ),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'lib/ui/assets/images/image_error.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => presenter.addFavorite(newsViewModel),
                  icon: Obx(
                    () => newsViewModel.isFavorite
                        ? Icon(
                            Icons.bookmark,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          )
                        : Icon(
                            Icons.bookmark_outline,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    newsViewModel.publishedAtFormated,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Text(
              newsViewModel.description,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(
            newsViewModel.content,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
