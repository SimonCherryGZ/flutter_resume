import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/presentation/album/album.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc()..add(FetchData()),
      child: Builder(
        builder: (context) {
          final bloc = context.read<AlbumBloc>();
          return PopScope(
            canPop: false,
            onPopInvoked: (_) async {
              final showAlbums = bloc.state.showAlbums;
              if (showAlbums) {
                bloc.add(ToggleAlbums());
                return;
              }
              context.go(AppRouter.home);
            },
            child: Scaffold(
              appBar: AppBar(
                title: const AlbumTitleBar(),
                titleTextStyle: TextStyle(
                  fontSize: 14.ss(),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    context.go(AppRouter.home);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              body: BlocListener<AlbumBloc, AlbumState>(
                listenWhen: (p, c) => p.hasAccess != c.hasAccess,
                listener: (context, state) {
                  if (!state.hasAccess) {
                    context.go(AppRouter.home);
                  }
                },
                child: const AlbumContentWidget(),
              ),
            ),
          );
        },
      ),
    );
  }
}
