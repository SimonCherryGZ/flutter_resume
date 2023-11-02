import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditorBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('编辑'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return StickerContainerWidget(
                        canvasWidth: constraints.maxWidth,
                        canvasHeight: constraints.maxHeight,
                      );
                    },
                  ),
                ],
              ),
            ),
            const EditorMaterialWidget(),
          ],
        ),
      ),
    );
  }
}
