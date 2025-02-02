import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_manager/photo_manager.dart';

class SampleTextToImageScreen extends StatefulWidget {
  const SampleTextToImageScreen({super.key});

  @override
  SampleTextToImageScreenState createState() => SampleTextToImageScreenState();
}

class SampleTextToImageScreenState extends State<SampleTextToImageScreen> {
  final GlobalKey _globalKey = GlobalKey();

  final TextEditingController _controller =
      TextEditingController(text: "Hello, Flutter!");

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveTextAsPng() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.hasAccess) {
      PhotoManager.openSetting();
      return;
    }

    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        debugPrint("转换 PNG 数据失败！");
        return;
      }
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // final directory = await getApplicationDocumentsDirectory();
      // final filePath = '${directory.path}/text.png';
      // File file = File(filePath);
      // await file.writeAsBytes(pngBytes);
      final title = 'text2image_${DateTime.now().millisecondsSinceEpoch}.png';
      await PhotoManager.editor.saveImage(
        pngBytes,
        filename: title,
        title: title,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("保存成功")),
      );
    } catch (e) {
      debugPrint("保存图片时发生错误：$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("保存失败：$e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("输入文字保存为 PNG"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "请输入文字",
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 50),
              RepaintBoundary(
                key: _globalKey,
                child: Text(
                  _controller.text,
                  style: const TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.grey[200],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _saveTextAsPng,
                child: const Text("保存为 PNG"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
