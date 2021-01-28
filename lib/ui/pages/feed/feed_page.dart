import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/main/pages/app_pages.dart';
import 'package:mesa_news/ui/components/reload_screen.dart';
import 'package:mesa_news/ui/pages/feed/components/carousel.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:mesa_news/ui/pages/filter/filter_presenter.dart';

import 'components/news.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  ScrollController _scrollController;
  final presenter = Get.find<FeedPresenter>();

  _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
      } else {
        if (!presenter.isFavorite) {
          presenter.loadMoreNews();
        }
      }
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mesa News',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final filterParams = await Get.toNamed(AppPages.filter);
              if (filterParams != null) {
                presenter.load(filterParams: filterParams);
              }
            },
            icon: Image.asset(
              'lib/ui/assets/icons/filter.png',
              alignment: Alignment.centerRight,
            ),
          )
        ],
      ),
      body: Obx(
        () {
          if (presenter.mainError.isNotEmpty) {
            return ReloadScreen(
              error: presenter.mainError,
              reload: presenter.load,
            );
          }

          if (presenter?.news?.length == 0 && presenter.isLoading == false) {
            return Center(
              child: ReloadScreen(
                  error: 'Nenhum registro encontrado',
                  reload: () {
                    Get.find<FilterPresenter>().clearFilter();
                    presenter.load();
                  }),
            );
          }

          return presenter.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  controller: _scrollController,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, bottom: 16, left: 16),
                      child: Text(
                        'Destaques',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Carousel(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 32, bottom: 8, left: 16),
                      child: Text(
                        'Últimas notícias',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (_, __) => Divider(),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: presenter.lastPage || presenter.isFavorite
                          ? presenter.news.length
                          : presenter.news.length + 1,
                      itemBuilder: (_, index) {
                        if (index < presenter.news.length) {
                          final newsViewModel = presenter.news[index];
                          return News(
                            newsViewModel: newsViewModel,
                          );
                        }
                        return Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }
}
