import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  final double _iconSize = 25;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditorBloc(iconSize: _iconSize),
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
                  StickerContainerWidget(iconSize: _iconSize),
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
