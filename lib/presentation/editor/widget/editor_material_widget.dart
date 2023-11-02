import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/editor/editor.dart';
import 'package:flutter_resume/utils/utils.dart';

class EditorMaterialWidget extends StatelessWidget {
  const EditorMaterialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = ['贴纸', '滤镜'];
    return DefaultTabController(
      length: tabs.length,
      child: Container(
        height: 250.ss(),
        color: Colors.white,
        child: Column(
          children: [
            TabBar(
              tabs: tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  StickerMaterialWidget(),
                  Center(child: Text('滤镜 - 占位，未实现')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
