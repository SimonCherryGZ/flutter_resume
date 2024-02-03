import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:palette/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late final ValueNotifier<List<int>?> _colorsNotifier;

  @override
  void initState() {
    super.initState();
    _colorsNotifier = ValueNotifier([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Palette 取色示例'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Image.asset('images/sample.jpg'),
              ),
              const SizedBox(height: 5),
              Expanded(
                flex: 6,
                child: ValueListenableBuilder(
                  valueListenable: _colorsNotifier,
                  builder: (context, colors, child) {
                    if (colors == null) {
                      return const Center(
                        child: Text('取色失败'),
                      );
                    }
                    if (colors.isEmpty) {
                      return Center(
                        child: ElevatedButton(
                          child: const Text('获取主色调'),
                          onPressed: () {
                            _getImagePrimaryColors();
                          },
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.0,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: colors.length,
                        itemBuilder: (context, index) {
                          int color = colors[index];
                          return _ColorItemWidget(color);
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _colorsNotifier.dispose();
    super.dispose();
  }

  Future<void> _getImagePrimaryColors() async {
    Uint8List imageBytes =
        (await rootBundle.load('images/sample.jpg')).buffer.asUint8List();
    final values = await Palette.getImagePrimaryColors(
      imageBytes,
      sampleSize: 256,
    );
    if (values == null) {
      _colorsNotifier.value = null;
      return;
    }
    final colors = List<int>.from(values);
    _colorsNotifier.value = colors;
  }
}

class _ColorItemWidget extends StatelessWidget {
  const _ColorItemWidget(this.color);

  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(color),
      child: Center(
        child: Text(
          '#${(color & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
