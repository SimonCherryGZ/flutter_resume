import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';

class StickerContainerWidget extends StatelessWidget {
  const StickerContainerWidget({
    super.key,
    required this.iconSize,
  });

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bloc = context.read<EditorBloc>();
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (details) {
            bloc.add(PanDown(details));
          },
          onPanUpdate: (details) {
            bloc.add(PanUpdate(details));
          },
          onPanEnd: (details) {
            bloc.add(PanEnd());
          },
          onPanCancel: () {
            bloc.add(PanCancel());
          },
          child: BlocBuilder<EditorBloc, EditorState>(
            builder: (context, state) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ...state.stickers.map((e) {
                    return StickerWidget(
                      stickerConfig: e,
                      iconSize: iconSize,
                    );
                  }).toList(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
