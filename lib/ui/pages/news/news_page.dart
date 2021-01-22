import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  'Amazon, Walmart and others battle price dd gouging on coronavirus-related products - CNBC',
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
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Text(
              'Amazon, Walmart and others battle price dd gouging on coronavirus-related products - CNBC',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(
            'Amazon, eBay, Walmart \n\n asodijf   asdpoif jsdi fisdf  sd\r asd ofijas dfo asodij asdfpoi jasdpoi asdpfoijasdfpoijasd fpoaisjdf apsoidfj asdpfoij asdpfoij asdfpoij asdfdf  sdfi sdfasdoijf asdofij  jsdifj jijsdf lorem  and Etsy  With many products sold out in stores, shoppers are racing to online retailers to order face masks, hand sanitizer, hazmat suits and other items to protect against the coronavirus.\r\nThe surge in demand has created an opening for third-party sellers on various have all struggled to curb price gouging and products that make unverified claims about the coronavirus.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
