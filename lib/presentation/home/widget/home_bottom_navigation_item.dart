import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class HomeBottomNavigationItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const HomeBottomNavigationItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: 60.ss(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.ss(),
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
            SizedBox(height: 2.ss()),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.ss(),
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
