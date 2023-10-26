import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/presentation/profile/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10nDelegate.l10n(context);
    final tabs = <String>[
      l10n.profileTabTrend,
      l10n.profileTabCollection,
    ];
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          body: NestedScrollView(
            controller: _controller,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: ProfileHeaderView(
                    user: widget.user,
                    tabs: tabs,
                    innerBoxIsScrolled: innerBoxIsScrolled,
                    scrollController: _controller,
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                UserFeedScreen(),
                UserCollectionScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
