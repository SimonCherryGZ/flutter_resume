import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/album/album.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumListView extends StatefulWidget {
  const AlbumListView({
    super.key,
    required this.paths,
    required this.showAlbums,
  });

  final List<AssetPathEntity> paths;
  final bool showAlbums;

  @override
  State<AlbumListView> createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  bool _transitionCompleted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _transitionCompleted = true;
        });
      } else if (status == AnimationStatus.reverse) {
        setState(() {
          _transitionCompleted = false;
        });
      } else if (status == AnimationStatus.dismissed) {
        route?.animation?.removeStatusListener(handler);
        setState(() {
          _transitionCompleted = true;
        });
      }
    }

    route?.animation?.addStatusListener(handler);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlbumBloc>();
    final screenHeight = MediaQuery.sizeOf(context).height;
    final offstage = !_transitionCompleted;
    return Offstage(
      offstage: offstage,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: Offset(0, widget.showAlbums ? 0 : -1),
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.6,
          color: Colors.white,
          child: ListView.separated(
            itemCount: widget.paths.length,
            itemBuilder: (context, index) {
              final path = widget.paths[index];
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
      ),
    );
  }
}
