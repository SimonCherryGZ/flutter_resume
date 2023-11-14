import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumPhotoGridView extends StatelessWidget {
  const AlbumPhotoGridView({
    super.key,
    required this.entities,
  });

  final List<AssetEntity> entities;

  @override
  Widget build(BuildContext context) {
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
            context.push(AppRouter.editor);
          },
          child: AssetEntityImage(
            entity,
            isOriginal: false,
            thumbnailSize: const ThumbnailSize.square(200),
            thumbnailFormat: ThumbnailFormat.jpeg,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
