import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/album/album.dart';
import 'package:flutter_resume/utils/utils.dart';

class AlbumTitleBar extends StatelessWidget {
  const AlbumTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlbumBloc>();
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        final currentPath = state.currentPath;
        if (currentPath == null) {
          return const SizedBox.shrink();
        }
        final showAlbums = state.showAlbums;
        final appBarHeight = AppBar().preferredSize.height;
        return SizedBox(
          height: appBarHeight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              bloc.add(ToggleAlbums());
            },
            child: UnconstrainedBox(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.ss()),
                height: appBarHeight / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(appBarHeight / 2),
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 100.ss(),
                      ),
                      child: Text(currentPath.name),
                    ),
                    SizedBox(width: 5.ss()),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: showAlbums ? 0.5 : 0,
                      child: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        size: 17.ss(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
