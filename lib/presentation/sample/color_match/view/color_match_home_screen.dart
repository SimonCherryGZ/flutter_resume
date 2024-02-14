import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class ColorMatchHomeScreen extends StatelessWidget {
  const ColorMatchHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modes = [
      _ModeModel('经典', Colors.red, AppRouter.sampleColorMatchClassic),
      _ModeModel('限时', Colors.green, AppRouter.sampleColorMatchTime),
      _ModeModel('多选一', Colors.blue, AppRouter.sampleColorMatchChoice),
      _ModeModel('极速', Colors.purple, AppRouter.sampleColorMatchRace),
    ];
    final screenSize = MediaQuery.sizeOf(context);
    final screenW = screenSize.width;
    final itemSize = screenW * 0.35;
    final spacing = screenW * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('颜色匹配'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: itemSize * 2,
              height: itemSize * 2,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                ),
                itemCount: modes.length,
                itemBuilder: (context, index) {
                  final mode = modes[index];
                  return _ModeItem(
                    width: itemSize,
                    height: itemSize,
                    color: mode.color,
                    label: mode.label,
                    onTap: () {
                      context.goNamed(mode.route);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeModel {
  final String label;
  final Color color;
  final String route;

  _ModeModel(
    this.label,
    this.color,
    this.route,
  );
}

class _ModeItem extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ModeItem({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        color: color,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.ss(),
            ),
          ),
        ),
      ),
    );
  }
}
