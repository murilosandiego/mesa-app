import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/main/pages/app_pages.dart';
import 'package:mesa_news/ui/components/reload_screen.dart';
import 'package:mesa_news/ui/pages/feed/components/carousel.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';

import 'components/news.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<FeedPresenter>();

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
            onPressed: () => Get.toNamed(AppPages.filter),
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

          return presenter.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
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
                      itemCount: presenter.news.length,
                      itemBuilder: (_, index) {
                        final newsViewModel = presenter.news[index];
                        return GestureDetector(
                          onTap: () => Get.toNamed(AppPages.news),
                          child: News(
                            newsViewModel: newsViewModel,
                          ),
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
