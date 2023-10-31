import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:provider/provider.dart';

class StickerMaterialWidget extends StatelessWidget {
  const StickerMaterialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePaths = [
      'assets/images/monkey_face_1.png',
      'assets/images/monkey_face_2.png',
    ];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.ss(),
        crossAxisSpacing: 10.ss(),
      ),
      padding: EdgeInsets.all(10.ss()),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        final imagePath = imagePaths[index];
        return GestureDetector(
          onTap: () {
            context.read<EditorBloc>().add(AddSticker(imagePath));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.ss()),
              color: Colors.grey.shade200,
            ),
            padding: EdgeInsets.all(10.ss()),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
