import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/home/home.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  final List<MapEntry<String, IconData>> itemConfigs;
  final Function(int index)? onTapItem;
  final VoidCallback? onTapActionButton;

  const HomeBottomNavigationBar({
    super.key,
    required this.itemConfigs,
    this.onTapItem,
    this.onTapActionButton,
  });

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  final LayerLink _actionTipsLayerLink = LayerLink();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.itemConfigs
                .asMap()
                .map<int, Widget>(
                  (i, e) => MapEntry(
                    i,
                    Expanded(
                      child: HomeBottomNavigationItem(
                        label: e.key,
                        icon: e.value,
                        isSelected: _selectedIndex == i,
                        onTap: () {
                          setState(() {
                            _selectedIndex = i;
                          });
                          widget.onTapItem?.call(i);
                        },
                      ),
                    ),
                  ),
                )
                .values
                .toList()
              ..insert(
                2,
                Expanded(
                  child: CompositedTransformTarget(
                    link: _actionTipsLayerLink,
                    child: HomeBottomActionButton(
                      onPressed: () {
                        widget.onTapActionButton?.call();
                      },
                    ),
                  ),
                ),
              ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (p, c) => p.showActionTips != c.showActionTips,
            builder: (context, state) {
              if (!state.showActionTips) {
                return const SizedBox.shrink();
              }
              return CompositedTransformFollower(
                link: _actionTipsLayerLink,
                followerAnchor: Alignment.bottomCenter,
                targetAnchor: Alignment.topCenter,
                offset: const Offset(0, 0),
                child: const ActionTipsWidget(),
              );
            },
          ),
        ],
      ),
    );
  }
}
