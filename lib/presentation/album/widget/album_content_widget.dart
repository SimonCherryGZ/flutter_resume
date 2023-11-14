import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/album/album.dart';

class AlbumContentWidget extends StatelessWidget {
  const AlbumContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        final paths = state.paths;
        final entities = state.entities;
        final showAlbums = state.showAlbums;
        return Stack(
          children: [
            AlbumPhotoGridView(entities: entities),
            AlbumListDimWidget(showAlbums: showAlbums),
            AlbumListView(paths: paths, showAlbums: showAlbums),
          ],
        );
      },
    );
  }
}
