import 'package:flutter/material.dart';
// import 'package:town/common/resource.dart';
// import 'package:town/common/util/util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:word/common/resource.dart';

class ImageBuild extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final String defImg;
  final BorderRadius borderRadius;
  const ImageBuild({Key key, this.url, this.height, this.width, this.fit, this.defImg, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image defaultImg = Image.asset(defImg ?? Asset.defImg84, fit: fit ?? BoxFit.cover);
    final Widget imageBox = SizedBox(
      width: width,
      height: height,
      child: url != null ?
        CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, imageUrl) {
            return defaultImg;
          },
          errorWidget: (context, imageUrl, error) {
            return defaultImg;
          }
        ) :
        defaultImg
    );
    return borderRadius != null ?
      ClipRRect(
        child: imageBox,
        borderRadius: borderRadius
      ) : imageBox;
  }
}