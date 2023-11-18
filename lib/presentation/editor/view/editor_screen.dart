import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canvasKey = GlobalKey();
    return BlocProvider(
      create: (context) => EditorBloc(canvasKey: canvasKey),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<EditorBloc, EditorState>(
              listenWhen: (p, c) => p.isShowLoading != c.isShowLoading,
              listener: (context, state) {
                final isShowLoading = state.isShowLoading;
                if (isShowLoading) {
                  EasyLoading.show();
                } else {
                  EasyLoading.dismiss();
                }
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: const Text('编辑'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<EditorBloc>().add(ExportImage());
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: RepaintBoundary(
                    key: canvasKey,
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
                ),
                const EditorMaterialWidget(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
