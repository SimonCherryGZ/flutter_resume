import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/trend/trend.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = <String>['热门', '发现', '关注'];
    return DefaultTabController(
      length: tabs.length,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
              const Divider(),
              const Expanded(
                child: TabBarView(
                  children: [
                    TrendScreen(),
                    Center(child: Text('发现')),
                    Center(child: Text('关注')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
