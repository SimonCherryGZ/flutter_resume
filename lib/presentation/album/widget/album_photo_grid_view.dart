import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class AlbumPhotoGridView extends StatelessWidget {
  const AlbumPhotoGridView({
    super.key,
    required this.entities,
  });

  final List<AssetEntity> entities;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final dp = MediaQuery.devicePixelRatioOf(context);
    final thumbnailSize =
        ThumbnailSize.square((screenSize.width / 4 * dp).toInt());
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 2.ss(),
        crossAxisSpacing: 2.ss(),
      ),
      itemCount: entities.length,
      itemBuilder: (context, index) {
        final entity = entities[index];
        return GestureDetector(
          onTap: () {
            context.goNamed(AppRouter.editor);
          },
          child: AssetEntityImage(
            entity,
            isOriginal: false,
            thumbnailSize: thumbnailSize,
            thumbnailFormat: ThumbnailFormat.jpeg,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
