import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  final String url;
  const DetailImage({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, err) => Icon(Icons.error),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

Widget _getPlaceholder() => Image.asset(
      'assets/images/no_image.png',
      fit: BoxFit.fill,
    );
