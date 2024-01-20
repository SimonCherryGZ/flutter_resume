import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class SampleRoundedCornerPinnedHeaderScreen extends StatelessWidget {
  const SampleRoundedCornerPinnedHeaderScreen({super.key});

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

class _AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('RoundedCornerPinnedHeader'),
      expandedHeight: 250.ss(),
      pinned: true,
      flexibleSpace: _HeaderBackgroundWidget(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.ss()),
        child: Container(
          height: 60.ss(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.ss()),
              topRight: Radius.circular(24.ss()),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: const Center(
            child: Text('Rounded Corner Pinned Header'),
          ),
        ),
      ),
    );
  }
}

class _HeaderBackgroundWidget extends StatelessWidget {
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
        ],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 20,
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
