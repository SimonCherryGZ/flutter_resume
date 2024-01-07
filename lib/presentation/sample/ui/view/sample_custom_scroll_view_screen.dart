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
          _BodyWidget(),
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

class _BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 50,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 40.ss(),
          child: Center(
            child: Text('$index'),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
