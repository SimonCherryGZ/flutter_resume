import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/album/album.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumListView extends StatelessWidget {
  const AlbumListView({
    super.key,
    required this.paths,
    required this.showAlbums,
  });

  final List<AssetPathEntity> paths;
  final bool showAlbums;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlbumBloc>();
    final screenHeight = MediaQuery.sizeOf(context).height;
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: Offset(0, showAlbums ? 0 : -1),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.6,
        color: Colors.white,
        child: ListView.separated(
          itemCount: paths.length,
          itemBuilder: (context, index) {
            final path = paths[index];
            return ListTile(
              title: Text(path.name),
              onTap: () {
                bloc.add(ToggleAlbums());
                bloc.add(SelectAlbum(index));
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
