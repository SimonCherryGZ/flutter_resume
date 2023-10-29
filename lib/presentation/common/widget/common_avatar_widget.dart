import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class CommonAvatarWidget extends StatelessWidget {
  const CommonAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    // multiavatar 访问不了
    /*
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey.shade300,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 200),
        errorWidget: (context, url, error) {
          return Icon(
            Icons.mood_bad,
            size: size / 2,
          );
        },
      ),
    );
    */
    // 换成哈希头像算了
    return ClipOval(
      child: Image.memory(
        IdenticonCache().getIdenticon(imageUrl),
        color: Colors.grey.shade200,
        colorBlendMode: BlendMode.dstOver,
        width: size,
        height: size,
        cacheWidth: size.toInt(),
        cacheHeight: size.toInt(),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
        gaplessPlayback: true,
      ),
    );
  }
}
