import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

import '../ui.dart';

class SampleCustomScrollViewScreen extends StatelessWidget {
  const SampleCustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBarWidget(),
          SliverToBoxAdapter(
            child: SizedBox(height: 10.ss()),
          ),
          const _TitleWidget('Horizontal List'),
          _SliverHorizontalListWidget(),
          const _TitleWidget('Grid'),
          _SliverGridWidget(),
          const _TitleWidget('Vertical List'),
          _SliverVerticalListWidget(),
        ],
      ),
    );
  }
}

class _AppBarWidget extends StatefulWidget {
  @override
  State<_AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<_AppBarWidget> {
  bool _floating = false;
  bool _pinned = false;
  bool _snap = false;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('CustomScrollView'),
      floating: _floating,
      pinned: _pinned,
      snap: _snap,
      expandedHeight: 250.ss(),
      flexibleSpace: _HeaderBackgroundWidget(
        floating: _floating,
        pinned: _pinned,
        snap: _snap,
        onChanged: (floating, pinned, snap) {
          setState(() {
            _floating = floating;
            _pinned = pinned;
            _snap = snap;
          });
        },
      ),
    );
  }
}

class _HeaderBackgroundWidget extends StatelessWidget {
  const _HeaderBackgroundWidget({
    required this.floating,
    required this.pinned,
    required this.snap,
    this.onChanged,
  });

  final bool floating;
  final bool pinned;
  final bool snap;
  final void Function(bool floating, bool pinned, bool snap)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AAOEcdM.img',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 75.ss(),
            child: AppBarBehaviorOptionsWidget(
              floating: floating,
              pinned: pinned,
              snap: snap,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}

class _SliverHorizontalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50.ss(),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: 10.ss(),
            vertical: 5.ss(),
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              color: Theme.of(context).primaryColorLight,
              width: 100.ss(),
              height: 40.ss(),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 10.ss());
          },
        ),
      ),
    );
  }
}

class _SliverGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(10.ss()),
      sliver: SliverGrid.builder(
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.ss(),
          crossAxisSpacing: 10.ss(),
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SliverVerticalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          color: Theme.of(context).primaryColorDark,
          height: 40.ss(),
          margin: EdgeInsets.symmetric(
            horizontal: 10.ss(),
            vertical: 5.ss(),
          ),
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
