import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/discover/discover.dart';
import 'package:flutter_resume/presentation/trend/trend.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    final tabs = <String>[l10n.feedTabTrend, l10n.feedTabDiscover];
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
              const Expanded(
                child: TabBarView(
                  children: [
                    TrendScreen(),
                    DiscoverScreen(),
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
