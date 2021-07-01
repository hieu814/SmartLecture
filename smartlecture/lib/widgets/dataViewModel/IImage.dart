import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/lecture_model/Image.dart' as t;

class IImage extends StatefulWidget {
  final t.Image image;
  const IImage({
    Key key,
    this.image,
  }) : super(key: key);
  @override
  _IImageState createState() => _IImageState();
}

class _IImageState extends State<IImage> {
  t.Image temp;
  @override
  void initState() {
    super.initState();
    temp = widget.image ?? new t.Image(url: "");
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: temp.url,
      placeholder: (context, url) => _getPlaceholder(),
      errorWidget: (context, url, error) => _getPlaceholder(),
      fit: BoxFit.fill,
    );
  }
}

Widget _getPlaceholder() => Image.asset(
      'assets/images/placeholder.jpg',
      fit: BoxFit.fill,
    );
//mdColors