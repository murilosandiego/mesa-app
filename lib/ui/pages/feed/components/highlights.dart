import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Highlights extends StatelessWidget {
  const Highlights({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
                imageUrl:
                    'https://image.cnbcfm.com/api/v1/image/106422372-1583253995153rtx7ashh.jpg?v=1583254080',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
                      'Amazon, Walmart and others  asoidj asdoifjas doijasd battle price gouging on coronavirus-related products - CNBC',
                      style: Theme.of(context).textTheme.headline3,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    height: 88,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
