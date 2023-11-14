import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/album/album.dart';

class AlbumListDimWidget extends StatelessWidget {
  const AlbumListDimWidget({
    super.key,
    required this.showAlbums,
  });

  final bool showAlbums;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlbumBloc>();
    return IgnorePointer(
      ignoring: !showAlbums,
      child: GestureDetector(
        onTap: () {
          bloc.add(ToggleAlbums());
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: showAlbums ? Colors.black87 : Colors.transparent,
        ),
      ),
    );
  }
}
