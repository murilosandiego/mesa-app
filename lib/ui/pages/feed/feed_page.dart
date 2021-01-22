import 'package:flutter/material.dart';

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
          News(),
        ],
      ),
    );
  }
}
