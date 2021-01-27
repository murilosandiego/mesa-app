import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/ui/pages/feed/news_viewmodel.dart';

class News extends StatelessWidget {
  final NewsViewModel newsViewModel;

  const News({@required this.newsViewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ImageHeader(newsViewModel: newsViewModel),
          __Bookmark(newsViewModel: newsViewModel),
          _Title(newsViewModel: newsViewModel),
          _Description(newsViewModel: newsViewModel),
        ],
      ),
    );
  }
}

class _ImageHeader extends StatelessWidget {
  const _ImageHeader({
    Key key,
    @required this.newsViewModel,
  }) : super(key: key);

  final NewsViewModel newsViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class __Bookmark extends StatelessWidget {
  const __Bookmark({
    Key key,
    @required this.newsViewModel,
  }) : super(key: key);

  final NewsViewModel newsViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 9, right: 14),
            child: Icon(
              Icons.bookmark_outline,
              color: Theme.of(context).primaryColor,
              size: 25,
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
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    @required this.newsViewModel,
  }) : super(key: key);

  final NewsViewModel newsViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 11, bottom: 8),
      child: Text(
        newsViewModel.title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key key,
    @required this.newsViewModel,
  }) : super(key: key);

  final NewsViewModel newsViewModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      newsViewModel.description,
      style: Theme.of(context).textTheme.bodyText1,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
