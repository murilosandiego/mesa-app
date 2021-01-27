import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mesa_news/ui/pages/feed/news_viewmodel.dart';

import '../feed_presenter.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentPage = 0;

  final PageController _pageController = PageController(
    viewportFraction: 0.92,
  );

  final presenter = Get.find<FeedPresenter>();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (_) {
      if (_currentPage <
          presenter.news
              .where((newsViewModel) => newsViewModel.highlight == true)
              .toList()
              .length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController?.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      child: PageView.builder(
        controller: _pageController,
        itemCount: presenter.news
            .where((newsViewModel) => newsViewModel.highlight == true)
            .toList()
            .length,
        itemBuilder: (_, index) {
          _currentPage = _currentPage == index ? index : _currentPage;
          final news = presenter.news
              .where((newsViewModel) => newsViewModel.highlight == true)
              .toList()[index];
          return _Highlights(newsViewModel: news);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _Highlights extends StatelessWidget {
  final NewsViewModel newsViewModel;
  const _Highlights({
    @required this.newsViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<FeedPresenter>();

    return Container(
      padding: EdgeInsets.only(right: 8),
      height: 128,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 128,
            height: 128,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: CachedNetworkImage(
                imageUrl: newsViewModel.imageUrl,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image.asset(
                  'lib/ui/assets/images/image_error.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      newsViewModel.title,
                      style: Theme.of(context).textTheme.headline3,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    height: 80,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          newsViewModel.publishedAt,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
