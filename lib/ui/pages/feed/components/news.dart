import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 128,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.cnbcfm.com/api/v1/image/106422372-1583253995153rtx7ashh.jpg?v=1583254080',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9, right: 14),
                  child: Image.asset('lib/ui/assets/icons/saved.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    '16 horas atrás',
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
            padding: const EdgeInsets.only(top: 11, bottom: 8),
            child: Text(
              'Amazon, Walmart and others battle price dd gouging on coronavirus-related products - CNBC',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Text(
            'Amazon, eBay, Walmart and Etsy have all struggled to curb price gouging and products that make unverified claims about the coronavirus.',
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
