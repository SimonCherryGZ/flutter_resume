import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class SampleNestedScrollViewScreen extends StatelessWidget {
  const SampleNestedScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['A', 'B', 'C'];
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _AppBarWidget(
                tabs: tabs,
                innerBoxIsScrolled: innerBoxIsScrolled,
              ),
            ];
          },
          body: _BodyWidget(tabs: tabs),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatefulWidget {
  const _AppBarWidget({
    required this.tabs,
    required this.innerBoxIsScrolled,
  });

  final List<String> tabs;
  final bool innerBoxIsScrolled;

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
      title: const Text('NestedScrollView'),
      floating: _floating,
      pinned: _pinned,
      snap: _snap,
      expandedHeight: 250.ss(),
      forceElevated: widget.innerBoxIsScrolled,
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
      bottom: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        tabs: widget.tabs.map((e) => Tab(text: e)).toList(),
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
          Center(
            child: _AppBarBehaviorOptionsWidget(
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

class _AppBarBehaviorOptionsWidget extends StatelessWidget {
  const _AppBarBehaviorOptionsWidget({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SwitchWidget(
          label: 'Floating',
          value: floating,
          onChanged: (floating) {
            if (snap == true && floating != true) {
              showToast('Snapping only applies when the app bar is floating');
            }
            onChanged?.call(floating, pinned, floating == false ? false : snap);
          },
        ),
        _SwitchWidget(
          label: 'Pinned',
          value: pinned,
          onChanged: (pinned) {
            onChanged?.call(floating, pinned, snap);
          },
        ),
        _SwitchWidget(
          label: 'Snap',
          value: snap,
          onChanged: (snap) {
            if (snap == true && floating != true) {
              showToast('Snapping only applies when the app bar is floating');
              return;
            }
            onChanged?.call(floating, pinned, snap);
          },
        ),
      ],
    );
  }
}

class _SwitchWidget extends StatelessWidget {
  const _SwitchWidget({
    required this.label,
    required this.value,
    this.onChanged,
  });

  final String label;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30.ss(),
          padding: EdgeInsets.symmetric(horizontal: 10.ss()),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.ss()),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: (value) {
            onChanged?.call(value);
          },
        ),
      ],
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    required this.tabs,
  });

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: tabs.map((e) {
        return ListView.separated(
          itemCount: 50,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 40.ss(),
              child: Center(
                child: Text('$e - $index'),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      }).toList(),
    );
  }
}
