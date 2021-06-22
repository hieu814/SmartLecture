import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';

class CacheImg extends StatefulWidget {
  final String url;
  const CacheImg({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  _CacheImgState createState() => _CacheImgState();
}

class _CacheImgState extends State<CacheImg> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url ?? "",
      placeholder: (context, url) => _getPlaceholder(),
      errorWidget: (context, url, error) => _getPlaceholder(),
      fit: BoxFit.fill,
    );
  }

  Widget _getPlaceholder() => Container();
}
