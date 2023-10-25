import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/config/router.dart';
import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:go_router/go_router.dart';

class ProfileHeaderView extends StatelessWidget {
  const ProfileHeaderView({
    super.key,
    required this.user,
    required this.tabs,
    required this.innerBoxIsScrolled,
    required this.scrollController,
  });

  final User user;
  final List<String> tabs;
  final bool innerBoxIsScrolled;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: AppBarTitle(
        user: user,
        scrollController: scrollController,
      ),
      forceElevated: innerBoxIsScrolled,
      pinned: true,
      stretch: true,
      expandedHeight: 200.ss(),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: AppBarFlexibleSpace(
          user: user,
          scrollController: scrollController,
        ),
        collapseMode: CollapseMode.parallax,
      ),
      bottom: TabBarWrapper(
        tabBar: TabBar(
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).disabledColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: tabs.map((String name) => Tab(text: name)).toList(),
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.user,
    required this.scrollController,
  });

  final User user;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            const Spacer(),
            IconButton(
              onPressed: () {
                context.push(AppRouter.setting);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        ListenableBuilder(
          listenable: scrollController,
          builder: (context, child) {
            final progress = scrollController.position.hasContentDimensions
                ? (scrollController.position.pixels /
                    scrollController.position.maxScrollExtent)
                : 0.0;
            return Opacity(
              opacity: progress,
              child: child,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonAvatarWidget(
                imageUrl: user.avatar,
                size: 30.ss(),
              ),
              SizedBox(width: 10.ss()),
              Text(
                user.nickname,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.ss(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppBarFlexibleSpace extends StatelessWidget {
  const AppBarFlexibleSpace({
    super.key,
    required this.user,
    required this.scrollController,
  });

  final User user;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAOEcdM.img',
          height: 220.ss(),
          fit: BoxFit.cover,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ListenableBuilder(
            listenable: scrollController,
            builder: (context, child) {
              final progress = scrollController.position.hasContentDimensions
                  ? (scrollController.position.pixels /
                      scrollController.position.maxScrollExtent)
                  : 0.0;
              return Opacity(
                opacity: 1 - progress,
                child: child,
              );
            },
            child: UserInfoWidget(
              user: user,
            ),
          ),
        ),
      ],
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20.ss()),
        CommonAvatarWidget(
          imageUrl: user.avatar,
          size: 60.ss(),
        ),
        SizedBox(width: 15.ss()),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.nickname,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.ss(),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.ss()),
            Text(
              user.email,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.ss(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TabBarWrapper extends StatelessWidget implements PreferredSizeWidget {
  const TabBarWrapper({
    super.key,
    required this.tabBar,
  });

  final TabBar tabBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.ss()),
          topRight: Radius.circular(20.ss()),
        ),
      ),
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => tabBar.preferredSize;
}
