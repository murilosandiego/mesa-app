import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/main/pages/app_pages.dart';

import 'components/highlights.dart';
import 'components/news.dart';

class FeedPage extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              'lib/ui/assets/icons/filter.png',
              alignment: Alignment.centerRight,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 16, left: 16),
            child: Text(
              'Destaques',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Container(
            height: 128,
            child: PageView(
              children: [
                Highlights(),
                Highlights(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16, left: 16),
            child: Text(
              'Últimas notícias',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppPages.news),
            child: News(),
          ),
        ],
      ),
    );
  }
}
