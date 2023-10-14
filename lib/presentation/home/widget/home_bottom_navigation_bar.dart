import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/home/widget/widget.dart';

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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
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
              child: HomeBottomActionButton(
                onPressed: () {
                  widget.onTapActionButton?.call();
                },
              ),
            ),
          ),
      ),
    );
  }
}
