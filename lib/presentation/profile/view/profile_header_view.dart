import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class ProfileHeaderView extends StatelessWidget {
  final List<String> tabs;
  final bool innerBoxIsScrolled;

  const ProfileHeaderView({
    super.key,
    required this.tabs,
    required this.innerBoxIsScrolled,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(
        children: [
          const Text('个人主页'),
          const Spacer(),
          IconButton(
            onPressed: () {
              // todo
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      forceElevated: innerBoxIsScrolled,
      pinned: true,
      stretch: true,
      expandedHeight: 200.ss(),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl:
              'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAOEcdM.img',
          fit: BoxFit.cover,
        ),
        collapseMode: CollapseMode.parallax,
      ),
      bottom: TabBar(
        tabs: tabs.map((String name) => Tab(text: name)).toList(),
      ),
    );
  }
}
