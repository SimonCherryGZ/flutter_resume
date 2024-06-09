import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';

class SampleNestedTabBarViewScreen extends StatelessWidget {
  const SampleNestedTabBarViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['A', 'B', 'C'];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NestedTabBarView'),
        ),
        body: Column(
          children: [
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
            Expanded(
              child: ExtendedTabBarView(
                children: tabs.map((e) {
                  return _SubTabView(
                    parentTab: e,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubTabView extends StatefulWidget {
  const _SubTabView({
    required this.parentTab,
  });

  final String parentTab;

  @override
  State<_SubTabView> createState() => _SubTabViewState();
}

class _SubTabViewState extends State<_SubTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tabs = ['1', '2', '3'];
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).disabledColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
          Expanded(
            child: ExtendedTabBarView(
              children: tabs.map((e) {
                return Center(
                  child: Text('${widget.parentTab}-$e'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
